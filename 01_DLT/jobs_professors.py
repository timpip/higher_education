import dlt
import requests
import json
import urllib.parse
from pathlib import Path
import os


def _get_ads(url_for_search, params):
    headers = {"accept": "application/json"}
    # Encode query parameter to handle special characters
    params['q'] = urllib.parse.quote(params['q'])
    
    response = requests.get(url_for_search, headers=headers, params=params)
    response.raise_for_status()  # check for HTTP errors
    return json.loads(response.content.decode("utf8"))


@dlt.resource(write_disposition="append")  # Use append for each query
def jobsearch_resource(params):
    url = "https://jobsearch.api.jobtechdev.se"
    url_for_search = f"{url}/search"
    
    if "offset" not in params:
        params["offset"] = 0
    
    limit = params["limit"]

    while True:
        response = _get_ads(url_for_search, params)

        # Print total number of hits on the first iteration
        if params["offset"] == 0:
            total_hits = response.get("total", 0)
            print(f"Total hits for query: {total_hits}")

        for ad in response["hits"]:
            yield ad  # Yield to the pipeline for storage

        if len(response["hits"]) < limit:
            break

        params["offset"] += limit


def run_pipeline(queries, table_name):
    # Create a pipeline to replace the entire table after all queries are fetched
    combined_pipeline = dlt.pipeline(
        pipeline_name="jobsearch_combined",
        destination="snowflake",
        dataset_name="staging",
    )

    # Replace the existing table with the data from the first query
    is_first_query = True

    for query in queries:
        print(f"Fetching data for query: {query}")
        
        # Initial search params
        params = {"q": query, "limit": 100}

        # Create a pipeline for each query and append the data to the combined table
        pipeline = dlt.pipeline(
            pipeline_name=f"jobsearch_{query.replace(' ', '_')}",
            destination="snowflake",
            dataset_name="staging",
        )
        
        # Run the pipeline and append the data to the table
        write_disposition = "replace" if is_first_query else "append"
        jobsearch_resource.write_disposition = write_disposition
        
        load_info = combined_pipeline.run(jobsearch_resource(params=params), table_name=table_name)
        print(f"Load info for query '{query}':", load_info, "\n")

        # After the first query, append the data from the next queries
        is_first_query = False


if __name__ == "__main__":
    working_directory = Path(__file__).parent
    os.chdir(working_directory)

    # List of queries to be used, including one with special characters
    queries = [
                "Doktorander",
                "Högskolelektor", 
                "Yrkeslärare", 
                "Universitetslektor",
                "Gymnasielärare",
                "Studie- och yrkesvägledare"
                ]
    table_name = "data_field_job_ads"

    # Run the pipeline for all queries
    run_pipeline(queries, table_name)

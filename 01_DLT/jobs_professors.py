import dlt
import requests
import json
from pathlib import Path
import os

def _get_ads(url_for_search, params):
    headers = {"accept": "application/json"}
    response = requests.get(url_for_search, headers=headers, params=params)
    response.raise_for_status()  # check for http errors
    return json.loads(response.content.decode("utf8"))


@dlt.resource(write_disposition="replace")
def jobsearch_resource(params, job_type):

    url = "https://jobsearch.api.jobtechdev.se"
    url_for_search = f"{url}/search"

    for ad in _get_ads(url_for_search, params)["hits"]:
        ad['job_type'] = job_type # job type will differentiate and distinguish to each record
        yield ad


def run_pipeline(queries, table_name):
    pipeline = dlt.pipeline(
        pipeline_name="jobsearch_he",
        destination="snowflake",
        dataset_name="staging",
    )
    for query, job_type in queries:
        params = {"q": query, "limit": 100}

        load_info = pipeline.run(jobsearch_resource(params=params, job_type = job_type), table_name=table_name)
        print(f"Loaded data for {job_type}: {load_info}")

# Gymnasielärare
# Lärare i yrkesämnen
# Professorer
# Studie- och yrkesvägledare
# Universitets- och högskolelektorer och
# Övriga universitets- och högskolelärare
if __name__ == "__main__":
    working_directory = Path(__file__).parent
    os.chdir(working_directory)

    
    queries = [
        ("Högskolelektor", "High School Teachers"),
        ("Yrkeslärare", "Vocational Teachers"),
        ("Professor", "Professors"),
        ("Studie-och yrkesvägledare", "Study and Career Counselors"),
        ("Universitetslektor", "University Lecturers"),
    ]

    table_name = "data_field_job_ads"


    run_pipeline(queries, table_name)
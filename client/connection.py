import requests
import json
from settings import settings

DEFAULT_USERNAME = 'remote_client'

def api_login():
    request_url = 'https://api.toolsformyjob.com/service/login'
    request_headers = {
        'Content-type': 'application/json', 
        'Accept': 'text/plain',
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36'
        }
    response = requests.post(
        request_url, 
        json={
            "username"      : DEFAULT_USERNAME,
            "api_key"       : "f27a729e-2489-41da-bcd0-20c487dfd4da",
            "secret_key"    : DEFAULT_USERNAME
        },
        timeout=5,
        headers=request_headers,
        allow_redirects=True
        )
    if response.status_code == 200:        
        return response.json()['data'][0]['Token']
    else:
        return None

def post_stats(request_body : object = {})    :
    request_url = 'https://api.toolsformyjob.com/stats/create'
    request_headers = {
        'Content-type': 'application/json', 
        'Accept': 'text/plain',
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36'
        }
    try:
        response = requests.post(
            request_url, 
            json=request_body,
            timeout=5,
            headers=request_headers,
            allow_redirects=True
            )
        log_transmitted(response.json())
    except:
        log_pending(request_body)

def log_pending(request_body : object):
    with open(app_settings.get_file_log_pending_path(), "a") as file_object:
        file_object.write(json.dumps(request_body) + '\n')

def log_transmitted(response: object):
    with open(app_settings.get_file_log_transmitted_path() , "a") as file_object:
        file_object.write(json.dumps(response) + '\n')

app_settings = settings()
if __name__ == '__main__':
    print(api_login())
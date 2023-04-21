import json
import os
import sys
from os.path import exists

import requests


class settings():

    SETTINGS_FILE_PRODUCTION = '//settings_production.json'
    SETTINGS_FILE_LOG_PENDING = '//log_pending.log'
    SETTINGS_FILE_LOG_TRANSMITTED = '//log_transmitted.log'
    indicators : None

    def __init__(self) -> None:
        self.get_configs()

    def get_application_path(self):
        if getattr(sys, 'frozen', False):
            return os.path.dirname(sys.executable)
        elif __file__:
            return os.path.dirname(__file__)
    
    def get_configs(self):
        path_app = self.get_application_path()
        file_production = path_app + self.SETTINGS_FILE_PRODUCTION
        if not exists(file_production):
            URL = "https://raw.githubusercontent.com/leiver-espinoza/JUNGLE/main/client/settings_production.json"
            response = requests.get(URL)
            open(file_production, "wb").write(response.content)
        with open(file_production,"r") as settings_file:
            tmp_client_settings = settings_file.read()
        self.indicators = json.loads(tmp_client_settings)['data']

    def set_configs(self,configuration_parameters : str):
        path_app = self.get_application_path()
        file_production = path_app + self.SETTINGS_FILE_PRODUCTION
        with open(file_production, 'w') as outfile:
            json.dump(configuration_parameters, outfile)

    def get_file_log_pending_path(self):
        return self.get_application_path() + self.SETTINGS_FILE_LOG_PENDING
    
    def get_file_log_transmitted_path(self):
        return self.get_application_path() + self.SETTINGS_FILE_LOG_TRANSMITTED

import os
from os.path import exists
import json
import sys
import shutil

class settings():

    SETTINGS_FILE_DEFAULT = '//settings_default.json'
    SETTINGS_FILE_PRODUCTION = '//settings_production.json'
    version : int
    indicators_settings : None

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
        q = exists(file_production) 
        if not exists(file_production):
            file_default = path_app + self.SETTINGS_FILE_DEFAULT
            shutil.copyfile(file_default,file_production)
        with open(file_production,"r") as settings_file:
            tmp_client_settings = settings_file.read()
        self.version = json.loads(tmp_client_settings)['version']
        self.indicators_settings = json.loads(tmp_client_settings)['indicators']
        pass

    def save_configs(self,configuration_parameters : str):
        pass

    def get_configs_version(self):
        pass

    def set_configs_version(self):
        pass
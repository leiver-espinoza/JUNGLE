# pip install psutil
# pip install pyinstaller
# pyinstaller client.py --onefile

import os
import threading
import time

import connection
from indicator_methods import defined_stats as class_defined_stats
from settings import settings as class_client_settings

token_value = ""
token_owner = ""
client_settings = class_client_settings()

clear_screen_command = {
    'Windows' : 'cls',
    'Linux' : 'clear',
    'Mac' : 'clear'
}
defined_stats = class_defined_stats()
os.system(clear_screen_command[defined_stats.sub_platform_name()])
defined_stats = None
clear_screen_command = None

controller = {}
token_value = connection.api_login()
token_owner = connection.DEFAULT_USERNAME

def InitializeIndicators():
    controller.clear()

    for indicator in client_settings.indicators:
        controller[indicator['indicator_key']] = {}
    ResetIndicators()

def ResetIndicators():
    for indicator in client_settings.indicators:
        controller[indicator['indicator_key']]['enabled'] = indicator['enabled']
        controller[indicator['indicator_key']]['interval_seconds'] = indicator['interval_seconds']

def Worker(indicator_key: str):
    while True:
        if controller[indicator_key]['enabled']:
            tmpRequestBody = getattr(globals()['class_defined_stats'](), 'get_' + ''.join(i for i in indicator_key if not i.isdigit()))(indicator_key)
            tmpRequestBody['token_owner'] = token_owner
            tmpRequestBody['token_value'] = token_value
            posting_result = connection.post_stats(tmpRequestBody)
            if posting_result:
                if (posting_result['data'][0]['pull_updates']):
                    connection.PullSettings()
                    client_settings.get_configs()
                    ResetIndicators()
        time.sleep(controller[indicator_key]['interval_seconds'])

def RunIndicators():
    for indicator_key in controller:
        controller[indicator_key]['process'] = \
            threading.Thread(target=Worker,
                                daemon=True,
                                args=(indicator_key,),
                                name='JUNGLE - ' + indicator_key)
        controller[indicator_key]['process'].start()

InitializeIndicators()
runner = threading.Thread(target=RunIndicators, daemon=True)
runner.start()

try:
    while True:
        input("Engine is running. Press CTRL+C to close finish the program.")
except KeyboardInterrupt:
    pass
print('\nMonitoring program is closing now...')
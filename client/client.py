# pip install psutil
# pip install pyinstaller
# pyinstaller client.py --onefile

import time
import os
import json
import sys
from indicator_methods import defined_stats as class_defined_stats
from settings import settings as class_client_settings
import threading
import connection

token_value = ""
token_owner = ""
client_settings = class_client_settings()

# def test():
#     try:
#         defined_stats = class_defined_stats()
#         while True:
#             # text = ""
#             # f = open(path_app + "/test.txt", "a")
#             # f.write(f"CPU Perc.: {psutil.cpu_percent()}\n")
#             # f.write(f"CPU Load Avg: {psutil.getloadavg()}\n")
#             # f.write("----------------------------------------------------------------------------------------------------\n")
#             # f.close()
#             os.system('cls')
#             print(defined_stats.get_mac_address('mac_address'))
#             print(defined_stats.get_ip_address("ip_address"))
#             print(defined_stats.get_boot_time("boot_time"))
#             print(defined_stats.get_time_since_boot("time_since_boot"))

#             # CPU
#             print(defined_stats.get_cpu_count("cpu_count"))
#             print(defined_stats.get_cpu_freq_min("cpu_freq_min"))
#             print(defined_stats.get_cpu_freq_current("cpu_freq_current"))
#             print(defined_stats.get_cpu_freq_max("cpu_freq_max"))
#             print(defined_stats.get_cpu_perc("cpu_perc"))

#             # Memory
#             print(defined_stats.get_memory_total_mb("memory_total_mb"))
#             print(defined_stats.get_memory_available_mb("memory_available_mb"))
#             print(defined_stats.get_memory_perc_used("memory_perc_used"))
#             print(defined_stats.get_memory_used_mb("memory_used_mb"))
#             print(defined_stats.get_memory_total_mb("memory_total_mb"))

#             # Disks
#             print(defined_stats.get_disk_read_count("disk_read_count"))
#             print(defined_stats.get_disk_write_count("disk_write_count"))
#             print(defined_stats.get_disk_read_bytes("disk_read_bytes"))
#             print(defined_stats.get_disk_write_bytes("disk_write_bytes"))
#             print(defined_stats.get_disk_read_time("disk_read_time"))
#             print(defined_stats.get_disk_write_time("disk_write_time"))

#             print(defined_stats.get_disk_space_total_mb("disk_space_total_mb"))
#             print(defined_stats.get_disk_space_used_mb("disk_space_used_mb"))
#             print(defined_stats.get_disk_space_free_mb("disk_space_free_mb"))
#             print(defined_stats.get_disk_space_percent("disk_space_percent"))

#             print(defined_stats.get_disk_space_total_mb("disk0_space_total_mb"))
#             print(defined_stats.get_disk_space_used_mb("disk0_space_used_mb"))
#             print(defined_stats.get_disk_space_free_mb("disk0_space_free_mb"))
#             print(defined_stats.get_disk_space_percent("disk0_space_percent"))

#             print(defined_stats.get_disk_space_total_mb("disk1_space_total_mb"))
#             print(defined_stats.get_disk_space_used_mb("disk1_space_used_mb"))
#             print(defined_stats.get_disk_space_free_mb("disk1_space_free_mb"))
#             print(defined_stats.get_disk_space_percent("disk1_space_percent"))

#             print(defined_stats.get_disk_space_total_mb("disk2_space_total_mb"))
#             print(defined_stats.get_disk_space_used_mb("disk2_space_used_mb"))
#             print(defined_stats.get_disk_space_free_mb("disk2_space_free_mb"))
#             print(defined_stats.get_disk_space_percent("disk2_space_percent"))

#             # Battery or charge
#             print(defined_stats.get_battery_percent("battery_percent"))
#             print(defined_stats.get_battery_power_plugged("battery_power_plugged"))
#             print(defined_stats.get_platform_name("platform_name"))        
#             time.sleep(1)
#     except KeyboardInterrupt:
#         pass

#test()

os.system('cls')
done = False

def worker(indicator_key: str, interval_seconds : int):
    while not done:
        tmpRequestBody = getattr(globals()['class_defined_stats'](), 'get_' + indicator_key)(indicator_key)
        tmpRequestBody['token_owner'] = token_owner
        tmpRequestBody['token_value'] = token_value
        connection.post_stats(tmpRequestBody)
        #print(getattr(globals()['class_defined_stats'](), 'get_' + indicator_key)(indicator_key))
        #print(tmpRequestBody)
        time.sleep(interval_seconds)


token_value = connection.api_login()
token_owner = connection.DEFAULT_USERNAME

# for indicator in client_settings.indicators:
#     indicator_key = indicator['indicator_key']
#     interval_seconds = indicator['interval_seconds']

#     threading.Thread(
#         target=worker, 
#         daemon=True, 
#         args=(
#             indicator['indicator_key'],
#             indicator['interval_seconds']
#         )).start()

indicator_key = "memory_total_mb"
print(getattr(globals()['class_defined_stats'](), 'get_' + indicator_key)(indicator_key))
indicator_key = "memory_available_mb"
print(getattr(globals()['class_defined_stats'](), 'get_' + indicator_key)(indicator_key))
indicator_key = "memory_perc_used"
print(getattr(globals()['class_defined_stats'](), 'get_' + indicator_key)(indicator_key))
indicator_key = "memory_used_mb"
print(getattr(globals()['class_defined_stats'](), 'get_' + indicator_key)(indicator_key))
indicator_key = "memory_free_mb"
print(getattr(globals()['class_defined_stats'](), 'get_' + indicator_key)(indicator_key))

input("press key")
done = True
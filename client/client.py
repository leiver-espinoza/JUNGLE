# pip install psutil
# pip install pyinstaller
# pyinstaller client.py --onefile
# PowerShell Update:
# https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.3#msi
# Installing a Service
# https://learn.microsoft.com/en-us/dotnet/framework/windows-services/how-to-install-and-uninstall-services

import time
import os
import json
import psutil
import sys
import methods


def get_path():
    if getattr(sys, 'frozen', False):
        return os.path.dirname(sys.executable)
    elif __file__:
        return os.path.dirname(__file__)


    path_app = get_path()

    #path_app = os.path.dirname(os.path.abspath(__file__))
    print(path_app)
    path_settings = path_app + '/settings/settings.json'
    with open(path_settings) as settings_file:
        client_settings = settings_file.read()
    client_settings = json.loads(client_settings)



    # Network
    print(f"Net IO Counters: {psutil.net_io_counters()}")
    print(f"Net if Address: {psutil.net_if_addrs()}")
    #print(f"IP Address: {methods.get_ip_address("ip_address")}")
    # ******* COMMENTING AS ADITIONAL CODING IS REQUIRED *******
    # Sprint(f"{psutil.net_if_addrs()['Ethernet Instance 0'][0][1]}")
    # print(f"{psutil.net_if_addrs()['Ethernet Instance 0'][1][1]}")
    # lines()

    # Other system info
    print('\nREVIEWING\n')
    print(f"Users: {psutil.users()}")

def test():
    path_app = get_path()
    try:
        while True:
            # text = ""
            # f = open(path_app + "/test.txt", "a")
            # f.write(f"CPU Perc.: {psutil.cpu_percent()}\n")
            # f.write(f"CPU Load Avg: {psutil.getloadavg()}\n")
            # f.write("----------------------------------------------------------------------------------------------------\n")
            # f.close()
            os.system('cls')
            print(methods.get_ip_address("ip_address"))
            print(methods.get_boot_time("boot_time"))
            print(methods.get_time_since_boot("time_since_boot"))

            # CPU
            print(methods.get_cpu_count("cpu_count"))
            print(methods.get_cpu_freq_min("cpu_freq_min"))
            print(methods.get_cpu_freq_current("cpu_freq_current"))
            print(methods.get_cpu_freq_max("cpu_freq_max"))
            print(methods.get_cpu_perc("cpu_perc"))

            # Memory
            print(methods.get_memory_total_mb("memory_total_mb"))
            print(methods.get_memory_available_mb("memory_available_mb"))
            print(methods.get_memory_perc_used("memory_perc_used"))
            print(methods.get_memory_used_mb("memory_used_mb"))
            print(methods.get_memory_total_mb("memory_total_mb"))

            # Disks
            print(methods.get_disk_read_count("disk_read_count"))
            print(methods.get_disk_write_count("disk_write_count"))
            print(methods.get_disk_read_bytes("disk_read_bytes"))
            print(methods.get_disk_write_bytes("disk_write_bytes"))
            print(methods.get_disk_read_time("disk_read_time"))
            print(methods.get_disk_write_time("disk_write_time"))

            print(methods.get_disk_space_total_mb("disk_space_total_mb"))
            print(methods.get_disk_space_used_mb("disk_space_used_mb"))
            print(methods.get_disk_space_free_mb("disk_space_free_mb"))
            print(methods.get_disk_space_percent("disk_space_percent"))

            print(methods.get_disk_space_total_mb("disk0_space_total_mb"))
            print(methods.get_disk_space_used_mb("disk0_space_used_mb"))
            print(methods.get_disk_space_free_mb("disk0_space_free_mb"))
            print(methods.get_disk_space_percent("disk0_space_percent"))

            print(methods.get_disk_space_total_mb("disk1_space_total_mb"))
            print(methods.get_disk_space_used_mb("disk1_space_used_mb"))
            print(methods.get_disk_space_free_mb("disk1_space_free_mb"))
            print(methods.get_disk_space_percent("disk1_space_percent"))

            print(methods.get_disk_space_total_mb("disk2_space_total_mb"))
            print(methods.get_disk_space_used_mb("disk2_space_used_mb"))
            print(methods.get_disk_space_free_mb("disk2_space_free_mb"))
            print(methods.get_disk_space_percent("disk2_space_percent"))

            # Battery or charge
            print(methods.get_battery_percent("battery_percent"))
            print(methods.get_battery_power_plugged("battery_power_plugged"))
            print(methods.get_platform_name("platform_name"))        
            time.sleep(1)
    except KeyboardInterrupt:
        pass

test()
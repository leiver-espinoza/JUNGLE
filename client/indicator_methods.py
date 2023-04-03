import socket
import os
import sys
import platform
import psutil
import datetime
from datetime import datetime as timestamp
import re

class defined_stats():
    ip_address : str = ''
    mac_address : str = ''

    def __init__(self) -> None:
        try:
            self.ip_address = self.get_ip_address('ip_address')['value']
            self.mac_address = self.get_mac_address('mac_address')['value']
        except Exception as ex:
            print(ex)

    def fn(self,number: int, digits: int = 2):
        if number < 10:
            return '0'*(digits-len(str(number))) + str(number)
        else:
            return str(number)

    def fd(self,value : timestamp):
        year    = str(value.year)
        month   = self.fn(value.month)
        day     = self.fn(value.day)
        hour    = self.fn(value.hour)
        minute  = self.fn(value.minute)
        second  = self.fn(value.second)
        return year + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second

    def compose_result(self,indicator_key : str, value):
        return {
            "client_mac_address"    : self.mac_address,
            "indicator_key"         : indicator_key,
            "ipaddress"             : self.ip_address,
            "value"                 : value,
            "reported_datetime"     : self.fd(timestamp.now())
        }

    def get_mac_address(self,indicator_key: str):
        tmp_value = None
        ip_address = self.get_ip_address('ip_address')['value']
        for key, value in (psutil.net_if_addrs().items()):
            if value[1][1] == ip_address:
                tmp_value = value[0][1]
                break
        return self.compose_result(indicator_key, tmp_value)

    def get_ip_address(self,indicator_key : str):
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("1.1.1.1", 80))
        value = s.getsockname()[0]
        return self.compose_result(indicator_key, value)

    def get_path(self,indicator_key : str):
        if getattr(sys, 'frozen', False):
            return os.path.dirname(sys.executable)
        elif __file__:
            return os.path.dirname(__file__)

    def get_platform_name(self,indicator_key : str):
        value = platform.system()
        return self.compose_result(indicator_key, value)

    def get_boot_time(self,indicator_key : str):
        boot_time = datetime.datetime.fromtimestamp(psutil.boot_time())
        value = self.fd(timestamp(
                boot_time.year, 
                boot_time.month, 
                boot_time.day, 
                boot_time.hour, 
                boot_time.minute,
                boot_time.second
            ))
        return self.compose_result(indicator_key, value)

    def get_time_since_boot(self,indicator_key : str):
        current_time = timestamp.now()
        boot_time = datetime.datetime.strptime(
            self.get_boot_time("boot_time").get("value"),
            "%Y-%m-%d %H:%M:%S")
        difference = current_time - boot_time
        days = difference.days

        remaining = difference.seconds
        seconds = difference.seconds % 60

        remaining = remaining - seconds
        minutes = int((remaining % 3600) / 60)

        remaining = remaining - (minutes * 60)
        hours = int(remaining / 3600)

        value = f"{self.fn(days,3)}:{self.fn(hours,2)}:{self.fn(minutes,2)}:{self.fn(seconds,2)}"
        return self.compose_result(indicator_key, value)

    def get_cpu_count(self,indicator_key : str):
        value = psutil.cpu_count()
        return self.compose_result(indicator_key, value)

    def get_cpu_freq_min(self,indicator_key : str):
        value = psutil.cpu_freq()[1]
        return self.compose_result(indicator_key, value)

    def get_cpu_freq_current(self,indicator_key : str):
        value = psutil.cpu_freq()[0]
        return self.compose_result(indicator_key, value)

    def get_cpu_freq_max(self,indicator_key : str):
        value = psutil.cpu_freq()[2]
        return self.compose_result(indicator_key, value)

    def get_cpu_perc(self,indicator_key : str):
        value = psutil.cpu_percent()
        return self.compose_result(indicator_key, value)

    def get_memory_total_mb(self,indicator_key : str):
        value = round(psutil.virtual_memory()[0]/1024/1024,2)
        return self.compose_result(indicator_key, value)

    def get_memory_available_mb(self,indicator_key : str):
        value = round(psutil.virtual_memory()[1]/1024/1024,2)
        return self.compose_result(indicator_key, value)

    def get_memory_perc_used(self,indicator_key : str):
        value = round(psutil.virtual_memory()[2]/100,4)
        return self.compose_result(indicator_key, value)

    def get_memory_used_mb(self,indicator_key : str):
        value = round(psutil.virtual_memory()[3]/1024/1024,2)
        return self.compose_result(indicator_key, value)

    def get_memory_free_mb(self,indicator_key : str):
        value = round(psutil.virtual_memory()[4]/1024/1024,2)
        return self.compose_result(indicator_key, value)

    # sdiskio(read_count=362724, write_count=933720, read_bytes=9531189760, write_bytes=31121600512, read_time=116, write_time=1042)
    def get_disk_read_count(self,indicator_key : str):
        value = psutil.disk_io_counters()[0]
        return self.compose_result(indicator_key, value)

    def get_disk_write_count(self,indicator_key : str):
        value = psutil.disk_io_counters()[1]
        return self.compose_result(indicator_key, value)

    def get_disk_read_bytes(self,indicator_key : str):
        value = psutil.disk_io_counters()[2]
        return self.compose_result(indicator_key, value)

    def get_disk_write_bytes(self,indicator_key : str):
        value = psutil.disk_io_counters()[3]
        return self.compose_result(indicator_key, value)

    def get_disk_read_time(self,indicator_key : str):
        value = psutil.disk_io_counters()[4]
        return self.compose_result(indicator_key, value)

    def get_disk_write_time(self,indicator_key : str):
        value = psutil.disk_io_counters()[5]
        return self.compose_result(indicator_key, value)

    # sdiskusage(total=249365385216, used=184323260416, free=52300460032, percent=77.9)
    def get_disk_space_total_mb(self,indicator_key : str):
        try:
            disk = re.findall(r'\d+', indicator_key)[0]
        except:
            disk = '0'
        try:
            value = round(psutil.disk_usage(psutil.disk_partitions()[int(disk)][0])[0]/1024/1024,2)
        except:
            value = None
        return self.compose_result(indicator_key, value)

    def get_disk_space_used_mb(self,indicator_key : str):
        try:
            disk = re.findall(r'\d+', indicator_key)[0]
        except:
            disk = '0'
        try:
            value = round(psutil.disk_usage(psutil.disk_partitions()[int(disk)][0])[1]/1024/1024,2)
        except:
            value = None
        return self.compose_result(indicator_key, value)

    def get_disk_space_free_mb(self,indicator_key : str):
        try:
            disk = re.findall(r'\d+', indicator_key)[0]
        except:
            disk = '0'
        try:
            value = round(psutil.disk_usage(psutil.disk_partitions()[int(disk)][0])[2]/1024/1024,2)
        except:
            value = None
        return self.compose_result(indicator_key, value)

    def get_disk_space_percent(self,indicator_key : str):
        try:
            disk = re.findall(r'\d+', indicator_key)[0]
        except:
            disk = '0'
        try:
            value = round(psutil.disk_usage(psutil.disk_partitions()[int(disk)][0])[3]/100,4)
        except:
            value = None
        return self.compose_result(indicator_key, value)

    # sbattery(percent=97, secsleft=<BatteryTime.POWER_TIME_UNLIMITED: -2>, power_plugged=True)
    def get_battery_percent(self,indicator_key : str):
        indicator = psutil.sensors_battery()
        if indicator:
            value = round(indicator[0]/100,4)
        else:
            value = None
        return self.compose_result(indicator_key, value)

    def get_battery_power_plugged(self,indicator_key : str):
        indicator = psutil.sensors_battery()
        if indicator:
            value = indicator[2]
        else:
            value = None
        return self.compose_result(indicator_key, value)

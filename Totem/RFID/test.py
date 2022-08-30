import requests
import getmac

mac = str(getmac.get_mac_address())
print(mac)

url = 'http://192.168.1.4:5000/totem'
myobj = {'rfid': 11, 'mac': mac}
x = requests.post(url, data = myobj)

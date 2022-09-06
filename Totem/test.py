import requests
import getmac

mac = str(getmac.get_mac_address())
print(mac)

url = 'http://192.168.187.252:5000/mobile'
myobj = {'rfid': 111, 'mac': mac}
x = requests.post(url, data = myobj)

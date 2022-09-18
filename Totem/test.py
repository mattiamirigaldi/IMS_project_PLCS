import requests
from getmac import get_mac_address as gma

url = 'http://192.168.21.252:5000/totem'
myobj = {'rfid':111, 'mac':gma()}
x = requests.post(url, data = myobj)

import requests
#from getmac import get_mac_address as gma

url = 'http://192.168.1.72:5000/totem'
myobj = {'rfid':32678}
x = requests.post(url, data = myobj)

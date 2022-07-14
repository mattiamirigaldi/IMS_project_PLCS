import requests

url = 'http://172.22.79.9:5000/totem'
myobj = {'rfid': 7777}
x = requests.post(url, data = myobj)

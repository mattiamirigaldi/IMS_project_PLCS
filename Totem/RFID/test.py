import requests

url = 'http://172.22.79.117:5000/totem'
myobj = {'rfid': 111}
x = requests.post(url, data = myobj)

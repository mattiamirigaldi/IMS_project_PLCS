import requests

url = 'http://172.22.32.101:5000/totem'
myobj = {'rfid': 123465}
x = requests.post(url, data = myobj)
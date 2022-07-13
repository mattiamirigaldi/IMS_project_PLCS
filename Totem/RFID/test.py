import requests

url = 'http://172.22.32.112:5000/totem'
myobj = {'rfid': 222}
x = requests.post(url, data = myobj)

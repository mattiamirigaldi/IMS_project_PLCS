import requests

url = 'http://192.168.1.2:5000/totem'
myobj = {'rfid': 4411}
x = requests.post(url, data = myobj)

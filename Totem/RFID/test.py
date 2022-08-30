import requests

url = 'http://192.168.1.4:5000/totem'
myobj = {'rfid': 888}
x = requests.post(url, data = myobj)

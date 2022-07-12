import requests

url = 'http://172.22.143.8:5000/totem'
myobj = {'rfid': 63463}
x = requests.post(url, data = myobj)

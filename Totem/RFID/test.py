import requests

url = 'http://172.22.32.108:5000/totem'
myobj = {'rfid': 63463}
x = requests.post(url, data = myobj)

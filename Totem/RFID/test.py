import requests

url = 'http://172.21.137.2:5000/totem'
myobj = {'rfid': 6666}
x = requests.post(url, data = myobj)

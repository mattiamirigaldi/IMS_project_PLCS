import requests

url = 'http://172.22.139.4:5000/totem'
myobj = {'rfid': 212121}
x = requests.post(url, data = myobj)

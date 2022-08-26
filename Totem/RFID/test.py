import requests

url = 'http://172.21.211.15:5000/mobile'
myobj = {'rfid': 222}
x = requests.post(url, data = myobj)

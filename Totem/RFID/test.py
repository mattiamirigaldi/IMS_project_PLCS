import requests

url = 'http://192.168.1.8:5000/mobile'
myobj = {'rfid': 696969}
x = requests.post(url, data = myobj)

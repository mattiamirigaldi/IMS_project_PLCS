import requests

url = 'http://192.168.1.6:5000/mobile'
myobj = {'rfid': 444}
x = requests.post(url, data = myobj)

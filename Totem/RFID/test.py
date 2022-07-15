import requests

url = 'http://172.22.78.128:5000/mobile'
myobj = {'rfid': 63463}
x = requests.post(url, data = myobj)

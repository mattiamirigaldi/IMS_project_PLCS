import requests

url = 'http://169.254.71.149:5000/mobile'
myobj = {'rfid': 28}
x = requests.post(url, data = myobj)

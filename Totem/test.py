import requests

url = 'http://10.202.0.2:5000/totem'
myobj = {'rfid':1361974461}
x = requests.post(url, data = myobj)

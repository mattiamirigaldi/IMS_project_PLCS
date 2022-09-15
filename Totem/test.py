import requests

url = 'http://192.168.1.8:5000/totem'
myobj = {'rfid':1375}
x = requests.post(url, data = myobj)

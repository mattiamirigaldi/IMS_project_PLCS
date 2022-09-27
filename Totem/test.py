import requests
from getmac import get_mac_address as gma

url = 'http://192.168.21.252:5000/totem'
rfid = 362041597987
hexrfid = hex(rfid)
hrfid = format(rfid,'x')
#myobj = {'rfid':111, 'mac':gma()}
#x = requests.post(url, data = myobj)
print (rfid)
print (hex(rfid))
print (format(rfid,'x'))
print (format(rfid,'x')[0:8])
print (int(format(rfid,'x')[0:8],16))
#!/usr/bin/env python3
import requests
import RPi.GPIO as GPIO
from mfrc522 import SimpleMFRC522
from getmac import get_mac_address as gma

mac = gma()
print(mac)
reader = SimpleMFRC522()
id , text = reader.read()
old = i = 1
url = 'http://192.168.115.252:5000/totem'

while (i < 8) :
       id, text = reader.read()
       if (old != id):
             print(id)
             print(text)
             old = id
             i += 1
             myobj = {'rfid':id , 'mac':mac}
             x = requests.post(url, data=myobj)
             print(x.text)
GPIO.cleanup()
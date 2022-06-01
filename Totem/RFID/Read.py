#!/usr/bin/env python
import requests
import RPi.GPIO as GPIO
from mfrc522 import SimpleMFRC522

reader = SimpleMFRC522()
read_flag = True

id, text = reader.read()
id_old = id

while read_flag:
        id, text = reader.read()
        print(id)
        print(text)

        myobj = {'rfid': id}
        
        url = 'http://172.22.16.210:5000/totem'
        x = requests.post(url, data = myobj)
        
        #print(x.text)
        #if id_old == id :
        #        read_flag = False

GPIO.cleanup()
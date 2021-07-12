#This is a basic projection acquisition script for the Raspberry Pi X-ray detector
#Detector is based on Raspberry Pi 3B+, Omnivision 5647 camera and scintillation screen from xray casettes, in lighttight enclosure
#author: markus.baecker@ovgu.de
#2019
import RPi.GPIO as GPIO
from time import sleep
from picamera import PiCamera
from time import sleep
from fractions import Fraction
import datetime
import os
import time

#today = datetime.datetime.now()
#place= "/home/pi/Desktop" + today
#os.mkdir(place)

#Base detector camera settings
steppin=23
expo= 1000000*6
Speed=0.005
GPIO.setmode(GPIO.BCM)
GPIO.setup(steppin,GPIO.OUT)
camera = PiCamera(
    resolution=(2592, 1680),
    framerate=(Fraction(1,4)),#Fraction(2,1),  #Cave: leaving a fraction framerate at camera closeing causes system freeze
    sensor_mode=0,
    )


#fixing camera settings
camera.shutter_speed = expo
print(camera.shutter_speed)
camera.iso = 800
#camera.start_preview(fullscreen=False, window=(2,2,400,400), alpha=218)
camera.exposure_mode = 'off'
camera.awb_mode='off'
camera.awb_gains=(1.2,1.8) #r 1.8,b 1.2
sleep(2)



p=time.time()
try:
    for i in range(4): #Number of acquisitons
        # each pulse equals 1.8 degree turn of sample
        GPIO.output(steppin,GPIO.LOW)
        sleep(Speed)
        GPIO.output(steppin,GPIO.HIGH)
        sleep(Speed)
        
        camera.capture('Light_%03d.jpeg'% i,use_video_port=True,quality=100)
        print ("Step: ")
        print (i+1)
except: #fix for camera freeze issue, caused by camera driver
    camera.framerate=5
    camera.close()
GPIO.output(steppin,GPIO.LOW)
print(time.time()-p)
camera.framerate=5
camera.close()
#GPIO.cleanup()

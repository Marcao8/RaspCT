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
steppin=23
expo= 1000000*6
Speed=0.005
GPIO.setmode(GPIO.BCM)
GPIO.setup(steppin,GPIO.OUT)
camera = PiCamera(
    resolution=(2592, 1680),
    framerate=(Fraction(1,4)),#Fraction(2,1), 
    sensor_mode=0,
    )
#(Fraction(1,6),30)

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
    for i in range(4): #start bei 0 bis 199
        GPIO.output(steppin,GPIO.LOW)
        sleep(Speed)
        GPIO.output(steppin,GPIO.HIGH)
        sleep(Speed)
        
        camera.capture('Light_%03d.jpeg'% i,use_video_port=True,quality=100)
        print ("Schritt")
        print (i+1)
except:
    camera.framerate=5
    camera.close()
GPIO.output(steppin,GPIO.LOW)
print(time.time()-p)
camera.framerate=5
camera.close()
#GPIO.cleanup()
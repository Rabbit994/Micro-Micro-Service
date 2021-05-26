import requests
import time
import random
import os

class Pixel:
    def __init__(self, token):
        self.token = token
        self.uri = "https://pixels.pythondiscord.com/set_pixel"
        self.sess = requests.session()
    
    def __get_header(self):
        return {"Authorization": f"Bearer {self.token}"}

    def set_pixel(self, x:int, y:int, rgb:str):
        data = {
            "x": x,
            "y": y,
            "rgb": rgb
        }
        r = self.sess.post(
            url= self.uri,
            json = data,
            headers = self.__get_header()
        )
        return r

    def convert_rgb(self, num:tuple) -> str:
        return '%02x%02x%02x' % num

x_maximum = 160
y_maximum = 90
with open('token.txt') as f:
    token = f.readlines()[0]
pixel = Pixel(token=token)
while True:
    rgb = (random.randint(0,255), random.randint(0,255), random.randint(0,255))
    try:
        r = pixel.set_pixel(
            x = random.randint(1,x_maximum),
            y = random.randint(1,y_maximum),
            rgb = str(pixel.convert_rgb(rgb))
        )
        headers = dict(r.headers)
        requests_remaining = r.headers.get('requests-remaining')
        requests_reset_after = r.headers.get('requests-reset')
        cooldown_reset = r.headers.get('Cooldown-Reset')
        #print(f"Requests remaining {requests_remaining}")
        #print(f"Requests reset {requests_reset_after}")
        
        print(r.json()['message'])
        if cooldown_reset is not None:
            print(f"In cooldown, sleeping for {cooldown_reset}")
            time.sleep(int(cooldown_reset))
        elif int(requests_remaining) == 0:
            #print(f"Sleeping for {requests_reset_after}")
            time.sleep(int(requests_reset_after))
        #print(r)
    except Exception as e:
        print(e)

import requests
import random
import os
import time

class Service:
    def __init__(self):
        self.base_url = os.getenv('base_url')
        self.sess = requests.Session()
        self.userid = []

    def __do_math(self, number1, number2, op):
        request = {
            'op': op,
            'number1': number1,
            'number2': number2
        }
        r = self.sess.post(
            url = f'{self.base_url}/math/calc',
            json = request
        )

    def __do_date(self, format):
        body = {
            'format': format
        }
        r = self.sess.post(
            url = f"{self.base_url}/date/today",
            json = body
        )

    def __do_new_user(self):
        r = self.sess.post(
            url = f"{self.base_url}/name/user"
        )
        self.userid.append(r.json()['userid'])

    def __do_get_user(self, userid):
        r = self.sess.get(
            url =  f"{self.base_url}/name/user?userid={userid}"
        )

    def __do_delete_user(self, userid):
        r = self.sess.delete(
            url = f"{self.base_url}/name/user?userid={userid}"
        )
        if r.status_code == 200:
            self.userid.remove(r.json()['userid'])
        pass

    def test_math(self):
        op_list = ["add", "subtract", "multiply", "divide", "expo", "remainder"]
        num1 = random.randint(0,100000)
        num2 = random.randint(0,100000)
        op = op_list[random.randint(0,len(op_list) - 1)]
        self.__do_math(num1, num2, op)

    def test_date(self):
        format = ['american','european','iso8601']
        self.__do_date(format[random.randint(0, len(format) - 1)])

    def test_user(self):
        user_op_list = ['new', 'get', 'delete']
        op = user_op_list[random.randint(0, len(user_op_list) - 1)]
        if op == 'new':
            self.__do_new_user()
        elif op == 'get' and len(self.userid) != 0:
            self.__do_get_user(self.userid[random.randint(0, len(self.userid) - 1)])
        elif op == 'delete' and len(self.userid) != 0:
            self.__do_delete_user(self.userid[random.randint(0, len(self.userid) - 1)])

service = Service()
list_of_services = ['math', 'date', 'user']
while True:
    try:
        operation = list_of_services[random.randint(0, len(list_of_services) - 1)]
        if operation == 'math':
            service.test_math()
        elif operation == 'date':
            service.test_date()
        elif operation == 'user':
            service.test_user()
        time.sleep(.1)
    except Exception as e:
        print(e)
        time.sleep(.1)
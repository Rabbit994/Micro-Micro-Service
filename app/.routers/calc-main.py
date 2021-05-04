import os

import requests

from fastapi import APIRouter
from pydantic import BaseModel

router = APIRouter()

class Calc(BaseModel):
    op: str
    number1: int
    number2: int

@router.post("/calc")
def calc(body: Calc):
    if body.op == "add":
        r = requests.get(url=f"{os.getenv('base_url')}/api/calc/add?num1={body.number1}&num2={body.number2}")
        return {"result": r.json()['result']}
    elif body.op == "subtract":
        r = requests.get(url=f"{os.getenv('base_url')}/api/calc/subtract?num1={body.number1}&num2={body.number2}")
        return {"result": r.json()['result']}
    elif body.op == "multiply":
        r = requests.get(url=f"{os.getenv('base_url')}/api/calc/multiply?num1={body.number1}&num2={body.number2}")
        return {"result": r.json()['result']}
    elif body.op == "divide":
        r = requests.get(url=f"{os.getenv('base_url')}/api/calc/divide?num1={body.number1}&num2={body.number2}")
        return {"result": r.json()['result']}
    elif body.op == "expo":
        r = requests.get(url=f"{os.getenv('base_url')}/api/calc/expo?num1={body.number1}&num2={body.number2}")
        return {"result": r.json()['result']}
    elif body.op == "remainder":
        r = requests.get(url=f"{os.getenv('base_url')}/api/calc/remainder?num1={body.number1}&num2={body.number2}")
        return {"result": r.json()['result']}
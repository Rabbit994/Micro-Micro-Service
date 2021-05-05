import os
import requests

from fastapi import APIRouter, HTTPException
from pydantic import BaseModel

router = APIRouter()

class Calc(BaseModel):
    op: str
    number1: int
    number2: int

@router.post("/")
def calc(body: Calc):
    if body.op == "add":
        r = requests.get(url=f"{os.getenv('base_url')}/api/calc/add?number1={body.number1}&number2={body.number2}")
        return {"result": r.json()['result']}
    elif body.op == "subtract":
        r = requests.get(url=f"{os.getenv('base_url')}/api/calc/subtract?number1={body.number1}&number2={body.number2}")
        return {"result": r.json()['result']}
    elif body.op == "multiply":
        r = requests.get(url=f"{os.getenv('base_url')}/api/calc/multiply?number1={body.number1}&number2={body.number2}")
        return {"result": r.json()['result']}
    elif body.op == "divide":
        r = requests.get(url=f"{os.getenv('base_url')}/api/calc/divide?number1={body.number1}&number2={body.number2}")
        return {"result": r.json()['result']}
    elif body.op == "expo":
        r = requests.get(url=f"{os.getenv('base_url')}/api/calc/expo?number1={body.number1}&number2={body.number2}")
        return {"result": r.json()['result']}
    elif body.op == "remainder":
        r = requests.get(url=f"{os.getenv('base_url')}/api/calc/remainder?number1={body.number1}&number2={body.number2}")
        return {"result": r.json()['result']}
    else:
        raise HTTPException(status_code=415, detail={"error": "operation not implemented"})


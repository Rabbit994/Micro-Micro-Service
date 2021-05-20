import os

from fastapi import APIRouter, HTTPException
from pydantic import BaseModel

router = APIRouter()

@router.get("/add")
def add(number1:int, number2:int):
    return {"result": int(number1 + number2)}

@router.get("/subtract")
def subtract(number1:int, number2:int):
    return {"result": int(number1 - number2)}

@router.get("/multiply")
def multiply(number1:int, number2:int):
    return {"result": int(number1 * number2)}

@router.get("/divide")
def divide(number1:int, number2:int):
    return {"result": int(number1 / number2)}

@router.get("/expo")
def expo(number1:int, number2:int):
    return {"result": int(number1 ** number2)}

@router.get("/remainder")
def remainder(number1:int, number2:int):
    return {"result": int(number1 % number2)}

import os
import requests

from fastapi import APIRouter, HTTPException
from pydantic import BaseModel

router = APIRouter()

class User:
    user_id: str

@router.get("/user")
def user(userid:str):
    pass

@router.post("/user")
def user_new():
    pass

@router.delete("/user")
def user_delete(userid:str):
    pass








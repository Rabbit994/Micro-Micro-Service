import os
import requests

from fastapi import APIRouter, HTTPException
from pydantic import BaseModel

router = APIRouter()

@router.get("/user")
def user_get(userid:str):
    sess = requests.Session()
    r = sess.get(url=f"{os.getenv('base_url')}/name/api/first?userid={userid}")
    first_name = r.json()['first_name']
    r = sess.get(url=f"{os.getenv('base_url')}/name/api/surname?userid={userid}")
    surname = r.json()['surname']
    r = sess.get(url=f"{os.getenv('base_url')}/name/api/email?userid={userid}")
    email = r.json()['email']
    return {
        "userid": userid,
        "first_name": first_name,
        "surname": surname,
        "email": email
    }

@router.post("/user")
def user_new():
    sess = requests.Session()
    r = sess.post(url=f"{os.getenv('base_url')}/name/api/userid")
    userid =  r.json()['userid']
    r = sess.post(url=f"{os.getenv('base_url')}/name/api/first?userid={userid}")
    first_name = r.json()['first_name']
    r = sess.post(url=f"{os.getenv('base_url')}/name/api/surname?userid={userid}")
    surname = r.json()['surname']
    r = sess.post(url=f"{os.getenv('base_url')}/name/api/email?userid={userid}")
    email = r.json()['email']
    return {
        "userid": userid,
        "first_name": first_name,
        "surname": surname,
        "email": email
    }

@router.delete("/user")
def user_delete(userid:str):
    sess = requests.Session()
    r = sess.delete(url=f"{os.getenv('base_url')}/name/api/userid")
    r = sess.delete(url=f"{os.getenv('base_url')}/name/api/first?userid={userid}")
    r = sess.delete(url=f"{os.getenv('base_url')}/name/api/surname?userid={userid}")
    r = sess.delete(url=f"{os.getenv('base_url')}/name/api/email?userid={userid}")
    return {
        "userid": userid
    }







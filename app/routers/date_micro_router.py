import os
import time
import datetime

from fastapi import APIRouter, HTTPException
from pydantic import BaseModel

router = APIRouter()

@router.get("/today_day")
def today_day():
    return {"day": datetime.datetime.today().day}

@router.get("/today_month")
def today_month():
    return {"month": datetime.datetime.today().month}

@router.get("/today_year")
def today_year():
    return {"year": datetime.datetime.today().year}

@router.get("/today_unix")
def today_unix():
    return {"unix_time": int(time.time())}
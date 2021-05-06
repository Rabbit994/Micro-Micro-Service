import os
import requests

from fastapi import APIRouter, HTTPException
from pydantic import BaseModel

router = APIRouter()

class Date(BaseModel):
    format: str

@router.post("/today")
def calc(body: Date):
    r = requests.get(url=f"{os.getenv('base_url')}/date/api/today_month")
    month = r.json()['month']
    r = requests.get(url=f"{os.getenv('base_url')}/date/api/today_day")
    day = r.json()['day']
    r = requests.get(url=f"{os.getenv('base_url')}/date/api/today_year")
    year = r.json()['year']
    if body.format == 'american':
        return {"today": f"{month}/{day}/{year}"}
    elif body.format == 'iso8061' or body.format == 'ISO8061':
        return {"today": f"{year}/{month}/{day}"}
    elif body.format == 'european':
        return {"today": f"{day}/{month}/{year}"}
    else:
        return {"today": f"{year}/{month}/{day}",
            "message": "Unknown format, defaulting to ISO8061"}

@router.post("/unixtime")
def date():
    r = requests.get(url=f"{os.getenv('base_url')}/date/api/today_unix")
    return r.json()['unix_time']




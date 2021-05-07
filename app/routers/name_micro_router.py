import os
import sqlite3

from fastapi import APIRouter, HTTPException
from pydantic import BaseModel

router = APIRouter()


@router.get("/first")
def user_get(userid:str):
    
    pass

@router.post("/first")
def user_new(userid:str):
    pass

@router.delete("/first")
def user_delete(userid:str):
    pass

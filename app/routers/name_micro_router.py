import os
import csv
import random

from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from ..modules.namesdb import FirstDB, LastDB, EmailDB
router = APIRouter()

class CSVReader:
    def generate_first_name(self) -> str:
        with open("names/firstname.csv") as f:
            reader = csv.reader(f)
            data = list(reader) #This makes a list of tuples
        return str(data[random.randint(1, len(data) - 1)][0])
    
    def generate_last_name(self) -> str:
        with open("names/surnames.csv") as f:
            reader = csv.reader(f)
            data = list(reader) #This makes a list of tuples
        return str(data[random.randint(1, len(data) - 1)][0])

@router.get("/first") #Get First Name by UserID
def first_user_get(userid:str):
    first_name = FirstDB().get_name(user_id=userid)
    return {"userid": userid, "first_name": first_name}

@router.post("/first") #Enter First Name into database
def first_user_new(userid:str):
    first_name = CSVReader().generate_first_name()
    FirstDB().add_name(
        first_name=first_name,
        user_id = userid
    )
    return {"userid": userid, "first_name": first_name}

@router.delete("/first") #Delete First Name from Database
def first_user_delete(userid:str):
    FirstDB().remove_name(userid)
    return {"userid": userid}

@router.get("/surname") #Get Surname Name by UserID
def surname_user_get(userid:str):
    pass

@router.post("/surname") #Create Surname and insert into database
def surname_user_new(userid:str):
    pass

@router.delete("/surname") #Delete Surname Name from Database
def surname_user_delete(userid:str):
    pass
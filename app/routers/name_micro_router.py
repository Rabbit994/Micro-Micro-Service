from app.routers.name_main_router import user
import csv
import random
import uuid

from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from ..modules.namesdb import FirstDB, LastDB, EmailDB, IDDb
router = APIRouter()

class CSVReader:
    def generate_first_name(self) -> str:
        with open("app/names/firstname.csv") as f:
            reader = csv.reader(f)
            data = list(reader) #This makes a list of tuples
        return str(data[random.randint(1, len(data) - 1)][0])
    
    def generate_last_name(self) -> str:
        with open("app/names/surnames.csv") as f:
            reader = csv.reader(f)
            data = list(reader) #This makes a list of tuples
        return str(data[random.randint(1, len(data) - 1)][0])

@router.get("/first") #Get First Name by UserID
def first_user_get(userid:str):
    try:
        first_name = FirstDB().get_name(user_id=userid)
        return {"userid": userid, "first_name": first_name}
    except AssertionError:
        raise HTTPException(status_code = 404, detail = "User ID does not exist")

@router.post("/first") #Enter First Name into database
def first_user_new(userid:str):
    try:
        first_name = CSVReader().generate_first_name()
        FirstDB().add_name(first_name = first_name, user_id = userid)
        return {"userid": userid, "first_name": first_name}
    except AssertionError:
        raise HTTPException(status_code = 409, detail= "User ID already exists")
        
@router.delete("/first") #Delete First Name from Database
def first_user_delete(userid:str):
    FirstDB().remove_name(userid)
    return {"userid": userid}

@router.get("/surname") #Get Surname Name by UserID
def surname_user_get(userid:str):
    try:
        last_name = LastDB().get_name(user_id=userid)
        return {"userid": userid, "surname": last_name}
    except AssertionError:
        raise HTTPException(status_code = 409, detail = "User ID does not exist")

@router.post("/surname") #Create Surname and insert into database
def surname_user_new(userid:str):
    try:
        last_name = CSVReader().generate_last_name()
        LastDB().add_name(last_name = last_name, user_id=userid)
        return {"userid": userid, "surname": last_name}
    except AssertionError:
        raise HTTPException(status_code = 409, detail= "User ID already exists")

@router.delete("/surname") #Delete Surname Name from Database
def surname_user_delete(userid:str):
    LastDB().remove_name(userid)
    return {"userid": userid}

@router.get("/email")
def email_get(userid:str):
    try:
        email = EmailDB().get_email(userid)
        return {"userid": userid, "email": email}
    except AssertionError:
        raise HTTPException(status_code = 404, detail = "User ID does not exist")

@router.post("/email")
def email_new(userid:str):
    try:
        fname = FirstDB().get_name(userid)
    except AssertionError:
        raise HTTPException(status_code = 404, detail = "First Name User ID does not exist")
    try:
        lname = LastDB().get_name(userid)
    except AssertionError:
        raise HTTPException(status_code = 404, detail = "Last Name User ID does not exist")
    try:
        edb = EmailDB()
        edb.add_email(
                first_name = fname,
                last_name = lname,
                user_id = userid
                )
        email = edb.get_email(userid)
        return {"userid": userid, "email": email}
    except AssertionError:
        raise HTTPException(status_code = 409, detail = "User ID already exists")

@router.delete("/email")
def email_delete(userid:str):
    EmailDB().remove_email(userid)
    return {"userid": userid}

@router.get("/alluserids")
def get_all_userids():
    user_ids = IDDb().get_all_userid()
    return {"user_ids": user_ids}

@router.post("/userid")
def add_userid():
    uuid = str(uuid.uuid4())
    try:
        IDDb().add_userid(uuid)
        return {"userid": uuid}
    except AssertionError:
        raise HTTPException(status_code = 409, detail = "User ID already exists")

@router.delete("/userid")
def remove_userid(userid:str):
    IDDb().remove_userid(user_id=userid)
    return {"userid": userid}


    

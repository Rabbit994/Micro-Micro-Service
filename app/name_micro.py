import os

from fastapi import APIRouter, FastAPI
from pydantic import main

from .routers import name_micro_router
from .modules.namesdb import FirstDB, IDDb, LastDB, EmailDB

app = FastAPI()

@app.on_event("startup")
def startup() -> None:
    # Setup the DBs
    FirstDB().setup_db()
    LastDB().setup_db()
    EmailDB().setup_db()
    IDDb().setup_db()

@app.get("/ping")
def ping():
    return 'pong'

app.include_router(
    name_micro_router.router,
    tags=["name_micro"],
    responses={404: {"description": "Not found"}}
)
import os

from fastapi import APIRouter, FastAPI
from pydantic import main

from .routers import date_main_router

app = FastAPI()

@app.get("/ping")
def ping():
    return 'pong'

app.include_router(
    date_main_router.router,
    tags=["date"],
    responses={404: {"description": "Not found"}}
)    
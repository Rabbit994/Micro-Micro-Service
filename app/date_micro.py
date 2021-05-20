import os

from fastapi import APIRouter, FastAPI
from pydantic import main

from .routers import date_micro_router

app = FastAPI()

@app.get("/ping")
def ping():
    return 'pong'

app.include_router(
    date_micro_router.router,
    tags=["date_micro"],
    responses={404: {"description": "Not found"}}
)
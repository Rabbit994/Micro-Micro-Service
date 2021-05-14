import os

from fastapi import APIRouter, FastAPI
from pydantic import main

from .routers import name_main_router

app = FastAPI()

@app.get("/ping")
def ping():
    return 'pong'

app.include_router(
    name_main_router.router,
    tags=["name"],
    responses={404: {"description": "Not found"}}
)
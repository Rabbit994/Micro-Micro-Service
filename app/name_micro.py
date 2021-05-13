import os

from fastapi import APIRouter, FastAPI
from pydantic import main

from .routers import name_micro_router

app = FastAPI()

@app.get("/ping")
def ping():
    return 'pong'

app.include_router(
    name_micro_router.router,
    tags=["name_micro"],
    responses={404: {"description": "Not found"}}
)
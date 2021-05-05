import os

from fastapi import APIRouter, FastAPI
from pydantic import main

from .routers import calc_main_router

app = FastAPI()

@app.get("/ping")
def ping():
    return 'pong'

app.include_router(
    calc_main_router.router,
    #prefix="/",
    tags=["calc"],
    responses={404: {"description": "Not found"}}
)

import os

from fastapi import APIRouter, FastAPI

from ..routers import calc_micro_router

app = FastAPI()

@app.get("/ping")
def ping():
    return 'pong'

app.include_router()
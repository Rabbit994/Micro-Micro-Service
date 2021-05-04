import os

from fastapi import APIRouter, FastAPI

app = FastAPI()

@app.get("/ping")
def ping():
    return 'pong'


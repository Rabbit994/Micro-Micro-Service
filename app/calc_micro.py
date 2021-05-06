import os

from fastapi import APIRouter, FastAPI

from .routers import calc_micro_router

app = FastAPI(openapi_url="/math/api/openapi.json")

@app.get("/ping")
def ping():
    return 'pong'

app.include_router(
    calc_micro_router.router,
    tags=["calc_micro"],
    responses={404: {"description": "Not found"}}
)
import os
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

@app.get("/me")
def get_me():
    return f"Hello, my name is {os.getenv('DATAHOW_GETME')}"

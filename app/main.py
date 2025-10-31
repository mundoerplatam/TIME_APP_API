from fastapi import FastAPI
from app import db, crud, models

app = FastAPI()

@app.get("/ping")
def ping():
    return {"message": "pong"}

@app.get("/users")
def read_users():
    return crud.get_users()

@app.post("/users")
def create_user(user: models.UserCreate):
    return crud.create_user(user)
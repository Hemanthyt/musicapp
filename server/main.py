from fastapi import FastAPI
from pydantic import BaseModel
from sqlalchemy import create_engine


DATABASE_URL = "postgresql://postgres:"

app = FastAPI()

class UserCreate(BaseModel):
    name: str
    email: str 
    password: str


app = FastAPI()


@app.post("/items/")
async def sigup_user(user: UserCreate):
    
    #extract data that comes from from req
    
    #check if the user already exists
    
    #add the user to the db 
    return user
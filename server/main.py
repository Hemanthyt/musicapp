from fastapi import FastAPI
from models.base import Base
from routes import auth
from database import engine
import uvicorn


app = FastAPI()
app.include_router(auth.router,prefix='/auth')


# Based on the this sqlalchemy will create a table
Base.metadata.create_all(engine)






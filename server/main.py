from fastapi import FastAPI
from models.base import Base
from routes import auth,song
from database import engine
import uvicorn


app = FastAPI()
app.include_router(auth.router,prefix='/auth')
app.include_router(song.router,prefix='/song')


# Based on the this sqlalchemy will create a table
Base.metadata.create_all(engine)






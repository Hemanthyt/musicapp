import bcrypt
from fastapi import Depends, HTTPException
import uuid
from sqlalchemy.orm import Session

from database import get_db
from models.user import User
from pydantic_schema.user_create import UserCreate
from fastapi import APIRouter

from pydantic_schema.user_login import UserLogin

router = APIRouter()

@router.post('/signup',status_code=201)
def signup_user(user:UserCreate,db:Session=Depends(get_db)):
    
    print('>>>>>'+user.email)
    print('>>>>>'+user.password)
    
    #check if the user already exists
    user_db = db.query(User).filter(User.email == user.email).first()
    
    if user_db:
         raise HTTPException(400,'User with the same email already exists!')
    
    hashed_pw = bcrypt.hashpw(user.password.encode(),bcrypt.gensalt(16))
    user_db = User(id=str(uuid.uuid4()),email=user.email,password=hashed_pw,name=user.name)
    
    #add the user to the db
    db.add(user_db)
    db.commit()
    db.refresh(user_db)
    
    return user_db

@router.post('/login')
def signin_user(user:UserLogin ,db:Session=Depends(get_db)):
    
    print('>>>>>'+user.email)
    print('>>>>>'+user.password)
    
    
    #check if a user with same email already exist
    user_db = db.query(User).filter(User.email == user.email).first()
    if not user_db:
        raise HTTPException(400,'User with this email does not exists!')
        
    #password matching or not
    hash_pw = bcrypt.hashpw(user.password.encode(),bcrypt.gensalt(16))
    ismatch = bcrypt.checkpw(user.password.encode(),user_db.password)
    
    if not ismatch:
        raise HTTPException(400,'Incorrect Password!')
    
   
    
    return user_db
    
    
    
    

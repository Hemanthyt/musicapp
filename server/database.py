from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker


DATABASE_URL = "postgresql://musicapp_owner:v2M6etWRjsOE@ep-shy-dew-a5txver1.us-east-2.aws.neon.tech/musicapp?sslmode=require"
# DATABASE_URL = "postgresql://postgres:2505@localhost:5431/musicapp"

engine = create_engine(DATABASE_URL);

# Call session.commit() explicitly if auto commmit is false
# if auto commit true it commits every single operation and not desirable
SessionLocal = sessionmaker(autocommit = False,autoflush=False,bind=engine)


# get access to database
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
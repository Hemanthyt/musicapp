from sqlalchemy import TEXT, VARCHAR, Column
from models.base import Base


class Playlist(Base):
    _tablename__ = "playlist"
    
    id=Column(TEXT,primary_key=True)
    name = Column(VARCHAR(100))
    songs = Column(list)
    
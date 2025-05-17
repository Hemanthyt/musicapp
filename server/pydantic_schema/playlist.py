from pydantic import BaseModel


class Playlist(BaseModel):
    id:str
    name: str
    songs:list
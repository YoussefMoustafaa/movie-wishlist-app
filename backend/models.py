from sqlalchemy import Column, Integer, String, ARRAY, JSON
from sqlalchemy.orm import relationship
from database import Base


class Movie(Base):
    __tablename__ = "movies"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String)
    description = Column(String)
    year = Column(String)
    runtime = Column(String)
    poster = Column(String)
    backdrops = Column(String)
    imdb_id = Column(String, unique=True)
    rating = Column(String)
    genres = Column(ARRAY(String))
    interactions = Column(JSON)
    platforms = Column(JSON)
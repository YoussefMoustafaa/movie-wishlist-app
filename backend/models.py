from sqlalchemy import Column, Integer, String, JSON, Table, ForeignKey
from sqlalchemy.orm import relationship
from database import Base


movie_platform_table = Table(
    "movie_platform", 
    Base.metadata,
    Column("movie_id", Integer, ForeignKey("movies.id")),
    Column("platform_id", Integer, ForeignKey("platforms.id"))
)


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
    genres = Column(String)
    interactions = Column(JSON)
    platforms = relationship("Platform", secondary=movie_platform_table, back_populates="movies")


class Platform(Base):
    __tablename__ = "platforms"

    id = Column(Integer, primary_key=True, index=True)
    platform_name = Column(String)
    monetization_type = Column(String)
    stream_quality = Column(String)
    price = Column(String)
    price_currency = Column(String)
    icon_url = String(String)
    link_url = String(String)

    movies = relationship("Movie", secondary=movie_platform_table, back_populates="platforms")
from sqlalchemy import Column, Integer, String, JSON, Table, ForeignKey, Enum, DECIMAL
from sqlalchemy.orm import relationship
from database import Base
import enum


class ContentType(enum.Enum):
    movie = "Movie"
    series = "Series"



class Movie(Base):
    __tablename__ = "movies"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String)
    description = Column(String)
    year = Column(Integer)
    runtime = Column(Integer)
    poster = Column(String)
    pictures = Column(String)
    imdb_id = Column(String, unique=True)
    rating = Column(DECIMAL(3, 1))  # max 9.9
    genres = Column(String)
    interactions = Column(JSON)
    type = Column(Enum(ContentType), default=ContentType.movie)
    number_of_seasons = Column(Integer, nullable=True)

    platform_links = relationship("MoviePlatformLink", back_populates="movie")


class Platform(Base):
    __tablename__ = "platforms"

    id = Column(Integer, primary_key=True, index=True)
    platform_name = Column(String)
    monetization_type = Column(String)
    stream_quality = Column(String)
    price = Column(Integer)
    price_currency = Column(String)
    icon_url = String(String)

    movie_links = relationship("MoviePlatformLink", back_populates="platform")


class MoviePlatformLink(Base):
    __tablename__ = "movie_platform_links"

    id = Column(Integer, primary_key=True)
    movie_id = Column(Integer, ForeignKey("movies.id"))
    platform_id = Column(Integer, ForeignKey("platforms.id"))
    link_url = Column(String)

    movie = relationship("Movie", back_populates="platform_links")
    platform = relationship("Platform", back_populates="movie_links")
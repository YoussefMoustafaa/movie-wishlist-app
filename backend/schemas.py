from pydantic import BaseModel
from typing import List, Optional
from enum import Enum


class ContentType(str, Enum):
    movie = "movie"
    series = "series"

class PlatformBase(BaseModel):
    platform_name: str
    monetization_type: str
    stream_quality: str
    price: int
    price_currency: str
    icon_url: str
    link_url: str

class PlatformOut(PlatformBase):
    class Config:
        orm_mode = True


class Interactions(BaseModel):
    likes: int
    dislikes: int


class MovieBase(BaseModel):
    title: str
    description: str
    year: int
    runtime: int
    poster: str
    pictures: List[str]
    imdb_id: str
    rating: float
    genres: List[str]
    type: ContentType = ContentType.movie
    number_of_seasons: Optional[int] = None


class MovieCreate(MovieBase):
    platforms: List[PlatformBase]

class MovieOut(MovieBase):
    platforms: List[PlatformOut]
    class Config:
        orm_mode = True

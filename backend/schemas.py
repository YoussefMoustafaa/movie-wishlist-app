from pydantic import BaseModel
from typing import List


class Platform(BaseModel):
    monetization_type: str
    stream_quality: str
    price: str
    price_currency: str
    platform_name: str
    icon_url: str
    link_url: str


class Interactions(BaseModel):
    likes: int
    dislikes: int


class MovieBase(BaseModel):
    title: str
    description: str
    year: str
    poster: str
    backdrops: List[str]
    runtime: str
    imdb_id: str
    rating: str
    genres: List[str]
    platforms: list[Platform]


class MovieCreate(MovieBase):
    pass

class MovieOut(MovieBase):
    class Config:
        orm_mode = True

from pydantic import BaseModel
from typing import List


class PlatformBase(BaseModel):
    platform_name: str
    monetization_type: str
    stream_quality: str
    price: str
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
    year: str
    poster: str
    backdrops: List[str]
    runtime: str
    imdb_id: str
    rating: str
    genres: List[str]


class MovieCreate(MovieBase):
    platforms: List[PlatformBase]

class MovieOut(MovieBase):
    platforms: List[PlatformOut]
    class Config:
        orm_mode = True

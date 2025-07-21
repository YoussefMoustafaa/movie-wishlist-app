from pydantic import BaseModel, Field, field_validator
from typing import List, Optional
from enum import Enum


class ContentType(str, Enum):
    movie = "Movie"
    series = "Show"

class PlatformBase(BaseModel):
    platform_name: str
    price_currency: Optional[str] = None
    icon_url: Optional[str] = None


class PlatformCreate(PlatformBase):
    pass


class PlatformOut(PlatformBase):
    id: int
    class Config:
        from_attributes = True


class Interactions(BaseModel):
    likes: Optional[int] = None
    dislikes: Optional[int] = None


class MoviePlatformLinkBase(BaseModel):
    monetization_type: Optional[str] = None
    stream_quality: Optional[str] = None
    price: Optional[float] = None
    link_url: str


class MoviePlatformLinkOut(MoviePlatformLinkBase):      # outputs the link with platform details
    id: int
    platform: PlatformOut
    class Config:
        from_attributes = True


class MoviePlatformLinkCreate(MoviePlatformLinkBase):
    movie_id: int
    platform_id: int


class MovieBase(BaseModel):
    title: str
    description: Optional[str]
    year: Optional[int] = None
    runtime: Optional[int] = None
    poster: Optional[str] = None
    pictures: Optional[List[str]] = None
    imdb_id: Optional[str] = None
    rating: Optional[float] = None  # max 9.9
    genres: Optional[List[str]] = None
    interactions: Optional[Interactions] = None
    type: ContentType = ContentType.movie
    number_of_seasons: Optional[int] = None
    platform_links: List[MoviePlatformLinkOut] = Field(default_factory=list)


    @field_validator("pictures", mode="before")
    @classmethod
    def parse_pictures(cls, value):
        if isinstance(value, str) and value.startswith("{") and value.endswith("}"):
            return value.strip("{}").split(",")
        return value

    @field_validator("genres", mode="before")
    @classmethod
    def parse_genres(cls, value):
        if isinstance(value, str) and value.startswith("{") and value.endswith("}"):
            return value.strip("{}").split(",")
        return value


class MovieCreate(MovieBase):
    pass  # used for creating a new movie, can be extended with more fields if needed


class MovieOut(MovieBase):
    id: int
    class Config:
        from_attributes = True
        use_enum_values = True


class PlatformMovieLinkOut(BaseModel):
    id: int
    link_url: str
    movie: MovieOut
    class Config:
        from_attributes = True
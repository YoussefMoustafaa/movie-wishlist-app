from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session
from database import Base, engine, SessionLocal
from models import Movie, Platform
from schemas import MovieOut, MovieCreate
from fetcher import fetch_and_save_movies
from typing import List


Base.metadata.create_all(bind=engine)

app = FastAPI()


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@app.get("/fetch/{query}")
def fetch_movies(query: str, db: Session = Depends(get_db)):
    return fetch_and_save_movies(query, db)
    # return {'message': "Movies fetched and stored successfully"}


@app.get("/movies", response_model=list[MovieOut])
def get_movies(db: Session = Depends(get_db)):
    return db.query(Movie).all()


@app.post("/movies", response_model=MovieOut)
def create_movie(movie: MovieCreate, db: Session = Depends(get_db)):
    db_movie = Movie(
        title=movie.title,
        description=movie.description,
        year=movie.year,
        poster=movie.poster,
        backdrops=movie.backdrops,
        runtime=movie.runtime,
        imdb_id=movie.imdb_id,
        rating=movie.rating,
        genres=movie.genres
    )
    db.add(db_movie)
    db.commit()
    db.refresh(db_movie)

    for p in movie.platforms:
        existing = (
            db.query(Platform).filter_by(platform_name=p.platform_name, link_url=p.link_url).first()
        )

        if not existing:
            existing = Platform(**p.dict())
            db.add(existing)
            db.flush()  # Use flush to get the id without committing
            db.refresh(existing)

        db_movie.platforms.append(existing)

    db.commit()


@app.get("/movies/platforms/{platform_name}", response_model=List[MovieOut])
def get_movies_by_platform(platform_name : str, db : Session = Depends(get_db)):
    return (
        db.query(Movie)
        .join(Movie.platforms)
        .filter(Platform.platform_name == platform_name)
        .all()
    )

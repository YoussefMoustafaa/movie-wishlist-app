from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session
from database import Base, engine, SessionLocal
from backend.models import Movie
from schemas import MovieOut
from fetcher import fetch_and_save_movies


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
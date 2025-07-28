from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session
from database import Base, engine, SessionLocal
from models import Movie, Platform, ContentType, MoviePlatformLink
from schemas import MovieOut, MovieCreate, PlatformOut
from fetcher import fetch_and_store_new_movies, fetch_movies_from_db, fetch_test
from typing import List
from apscheduler.schedulers.background import BackgroundScheduler
from contextlib import asynccontextmanager
from fastapi.middleware.cors import CORSMiddleware


scheduler = BackgroundScheduler()

def fetch_daily_movies_job():
    db = SessionLocal()
    try:
        fetch_and_store_new_movies(db)
    except Exception as e:
        print(f"Error in scheduled job: {e}")
    finally:
        db.close()

scheduler.add_job(fetch_daily_movies_job, 'cron', hour=3, minute=0)


@asynccontextmanager
async def lifespan(app: FastAPI):
    scheduler.start()
    yield
    scheduler.shutdown()


Base.metadata.create_all(bind=engine)

app = FastAPI(lifespan=lifespan)


app.add_middleware(
    CORSMiddleware,
    allow_origins=["127.0.0.1"],  # or specify your Flutter IP
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@app.get("/fetch/{query}")
def fetch_movies(query: str, db: Session = Depends(get_db)):
    return fetch_and_store_new_movies(query, db)
    # return {'message': "Movies fetched and stored successfully"}


# @app.get("/movies", response_model=list[MovieOut])
# def get_movies(db: Session = Depends(get_db)):
#     return db.query(Movie).all()


@app.get("/movies", response_model=List[MovieOut])
def get_movies_from_db(query: str, db: Session = Depends(get_db)):
    return fetch_movies_from_db(query, db)


@app.get("/movies/fresh", response_model=List[MovieOut])
def get_fresh_movies(query: str, db: Session = Depends(get_db)):
    return fetch_and_store_new_movies(query, db)


@app.get("/movies/", response_model=MovieOut)
def get_movie_by_id(movie_id: int, db: Session = Depends(get_db)):
    movie = db.query(Movie).filter(Movie.id == movie_id).first()
    if not movie:
        return {"error": "Movie not found"}
    return movie


@app.get("/platforms", response_model=List[PlatformOut])
def get_platforms(db: Session = Depends(get_db)):
    return db.query(Platform).all()


@app.get("/movies/platforms/{platform_name}", response_model=List[MovieOut])
def get_movies_by_platform(platform_name : str, db : Session = Depends(get_db)):
    return (
        db.query(Movie)
        .join(Movie.platforms)
        .filter(Platform.platform_name == platform_name)
        .all()
    )


@app.get("/movies/test/")
def test_fetch_movies(query: str, db: Session = Depends(get_db)):
    return fetch_test(query, db)

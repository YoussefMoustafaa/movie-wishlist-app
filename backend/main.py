from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session
from database import Base, engine, SessionLocal
from models import Movie, Platform
from schemas import MovieOut, MovieCreate
from fetcher import fetch_and_save_movies, fetch_api_movies
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


@app.get("/search", response_model=List[MovieOut])
def search_cached(query: str, db: Session = Depends(get_db)):
    query = query.strip().lower()

    db_results = db.query(Movie).filter(Movie.title.ilike(f"%{query}%")).all()

    return db_results


@app.get("/search/fresh", response_model=List[MovieOut])
def search_fresh(query: str, db: Session = Depends(get_db)):
    query = query.strip().lower()

    existing_movies = db.query(Movie).filter(Movie.title.ilike(f"%{query}%")).all()
    existing_ids = {movie.imdb_id for movie in existing_movies}

    external_movies = fetch_api_movies(query)

    new_movies = []

    for ext in external_movies:
        if ext.imdb_id in existing_ids:
            continue

        platforms = []

        ext.offers[0]

        # TODO price is int and price_value is string, handle that
        for offer in ext.offers:
            platform = Platform(
                platform_name=offer.package.name,
                monetization_type=offer.monetization_type,
                stream_quality=offer.presentation_type,
                price=int(offer.price_value),
                price_currency=offer.price_currency,
                icon_url=offer.package.icon,
                link_url=offer.url
            )

        numOfSeasons = None
        if ext.object_type == "SHOW":
            numOfSeasons = ext.offers[0].element_count

        new_movie = Movie(
            imdb_id=ext.imdb_id,
            title=ext.title,
            description=ext.short_description,
            runtime=ext.runtime_minutes,
            poster=ext.poster,
            backdrops=ext.backdrops,
            genres=ext.genres,
            rating=ext.scoring.imdb_score,
            year=ext.release_year,
            interactions={
                "likes": ext.interactions.likes if ext.interactions else 0,
                "dislikes": ext.interactions.dislikes if ext.interactions else 0
            },
            type=ext.object_type,
            number_of_seasons=numOfSeasons
        )


# @app.post("/movies", response_model=MovieOut)
# def create_movie(movie: MovieCreate, db: Session = Depends(get_db)):
#     db_movie = Movie(
#         title=movie.title,
#         description=movie.description,
#         year=movie.year,
#         poster=movie.poster,
#         backdrops=movie.backdrops,
#         runtime=movie.runtime,
#         imdb_id=movie.imdb_id,
#         rating=movie.rating,
#         genres=movie.genres
#     )
#     db.add(db_movie)
#     db.commit()
#     db.refresh(db_movie)

#     for p in movie.platforms:
#         existing = (
#             db.query(Platform).filter_by(platform_name=p.platform_name, link_url=p.link_url).first()
#         )

#         if not existing:
#             existing = Platform(**p.dict())
#             db.add(existing)
#             db.flush()  # Use flush to get the id without committing
#             db.refresh(existing)

#         db_movie.platforms.append(existing)

#     db.commit()


@app.get("/movies/platforms/{platform_name}", response_model=List[MovieOut])
def get_movies_by_platform(platform_name : str, db : Session = Depends(get_db)):
    return (
        db.query(Movie)
        .join(Movie.platforms)
        .filter(Platform.platform_name == platform_name)
        .all()
    )

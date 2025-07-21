import requests
import ast
from sqlalchemy.orm import Session
from models import Movie, Platform, MoviePlatformLink, ContentType
from schemas import MovieCreate
from simplejustwatchapi.justwatch import search, details

API_KEY = ""


def fetch_api_movies(query: str):
    try:
        results = search(query, "eg", "en")

        if results:
            return results
        else:
            print("No Movies Found!")
            return []
    except requests.RequestException as e:
        print(f"Error fetching movies: {e}")
        return []
    

def fetch_and_store_new_movies(query: str, db: Session):
    query = query.strip().lower()

    existing_movies = db.query(Movie).filter(Movie.title.ilike(f"%{query}%")).all()
    existing_ids = {movie.imdb_id for movie in existing_movies}

    external_movies = fetch_api_movies(query)

    for ext in external_movies:
        if ext.imdb_id in existing_ids:
            continue


        numOfSeasons = None
        if ext.object_type == "SHOW":
            content_type = ContentType.series
        else:
            content_type = ContentType.movie
        if ext.offers:
            numOfSeasons = ext.offers[0].element_count



        movie = Movie(
            imdb_id=ext.imdb_id,
            title=ext.title,
            description=ext.short_description,
            runtime=int(ext.runtime_minutes),
            poster=ext.poster,
            pictures=ext.backdrops if ext.backdrops else [],
            genres=ext.genres if ext.genres else [],
            rating=float(ext.scoring.imdb_score) if ext.scoring.imdb_score else 0.0,
            year=int(ext.release_year),
            interactions={
                "likes": int(ext.interactions.likes) if ext.interactions else 0,
                "dislikes": int(ext.interactions.dislikes) if ext.interactions else 0
            },
            type=content_type,
            number_of_seasons=numOfSeasons,
        )
        db.add(movie)
        db.flush()


        for offer in ext.offers:
            platform = db.query(Platform).filter_by(platform_name=offer.package.name).first()
            
            if not platform:
                platform = Platform(
                    platform_name=offer.package.name,
                    icon_url=str(offer.package.icon),
                )
                db.add(platform)
                db.flush()
            

            existing_link = db.query(MoviePlatformLink).filter_by(
                movie_id=movie.id,
                platform_id=platform.id,
            ).first()

            if not existing_link:
                link = MoviePlatformLink(
                    movie=movie,
                    platform=platform,
                    link_url=offer.url,
                    monetization_type=offer.monetization_type,
                    stream_quality=offer.presentation_type,
                    price=float(offer.price_value) if offer.price_value else None,
                    price_currency=offer.price_currency,
                )
                db.add(link)
                db.flush()

    db.commit()
    
    return db.query(Movie).filter(Movie.title.ilike(f"%{query}%")).all()


def fetch_movies_from_db(query: str, db: Session):
    query = query.strip().lower()
    return db.query(Movie).filter(Movie.title.ilike(f"%{query}%")).all()

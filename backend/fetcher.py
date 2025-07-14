import requests
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
        content_type = ContentType.movie
        if ext.object_type == "SHOW":
            content_type = ContentType.series
        if ext.offers:
            numOfSeasons = ext.offers[0].element_count


        movie = Movie(
            imdb_id=ext.imdb_id,
            title=ext.title,
            description=ext.short_description,
            runtime=int(ext.runtime_minutes),
            poster=ext.poster,
            backdrops=ext.backdrops,
            genres=ext.genres,
            rating=float(ext.scoring.imdb_score),
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
            platform = None
            existing_platform = db.query(Platform).filter_by(platform_name=offer.package.name).first()
            if existing_platform:
                platform = existing_platform
            else:
                platform = Platform(
                    platform_name=offer.package.name,
                    monetization_type=offer.monetization_type,
                    stream_quality=offer.presentation_type,
                    price=int(offer.price_value),
                    price_currency=offer.price_currency,
                    icon_url=offer.package.icon,
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
                    link_url=offer.url
                )
                db.add(link)
                db.flush()

    db.commit()


def fetch_and_save_movies(query: str, db: Session):
    # search_url = f"https://www.omdbapi.com/?apikey={API_KEY}&s={query}"
    results = search(query, "eg", 'en')
    
    if results:
        # for movie in results:

        #     # Check if the movie already exists in the database
        #     existing_movie = db.query(Movie).filter(Movie.id == movie.id).first()
        #     if existing_movie:
        #         continue

        #     # Create a new Movie instance
        #     new_movie = Movie(
        #         imdb_id=movie.imdb_id,
        #         title=movie.title,
        #         description=movie.short_description,
        #         runtime=movie.runtime_minutes,
        #         poster=movie.poster,
        #         backdrops=movie.backdrops,
        #         genres=movie.genres,
        #         rating=movie.scoring.imdb_score,
        #         year=movie.release_year,
        #         interactions={
        #             "likes": movie.interactions.likes if movie.interactions else 0,
        #             "dislikes": movie.interactions.dislikes if movie.interactions else 0
        #         }
        #     )

            # db.add(new_movie)
        print(results[0])
        return results
        
        # db.commit()

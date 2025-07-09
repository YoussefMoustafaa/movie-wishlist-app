import requests
from sqlalchemy.orm import Session
from models import Movie
from schemas import MovieCreate
from simplejustwatchapi.justwatch import search

API_KEY = ""

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

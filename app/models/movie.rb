require 'open-uri'

class Movie < ActiveRecord::Base

  def self.page_count
    result = JSON.parse(open("https://api.themoviedb.org/3/discover/movie?api_key=db59ec8dd4e4fb35231cdbe0ffbbd007&sort_by=vote_average.desc&vote_count.gte=15&vote_average.gte=7.5&page=1").read)
    return result["total_pages"]
  end

  def self.get_movie(page_count)
    random_num = rand(page_count) + 1
    result = JSON.parse(open("https://api.themoviedb.org/3/discover/movie?api_key=db59ec8dd4e4fb35231cdbe0ffbbd007&sort_by=vote_average.desc&vote_count.gte=15&vote_average.gte=7.5&page=#{random_num}").read)
    #refactor into two mehtods: get random page & get random movie from page)
    movie_id = result["results"].sample["id"]
    JSON.parse(open("https://api.themoviedb.org/3/movie/#{movie_id}?api_key=db59ec8dd4e4fb35231cdbe0ffbbd007&append_to_response=trailers").read)
  end

  def self.build_movie(result)
    #taking the first genre of the movie
    genre     = result["genres"][0]["name"]
    title     = result["title"]
    rating    = result["vote_average"]
    source_id = result["trailers"]["youtube"][0]["source"]
    poster    = "http://image.tmdb.org/t/p/w500" + result["poster_path"]

    self.create(title: title, genre: genre, rating: rating, source_id: source_id, poster: poster)
  end

  def self.pick_movie
    trailers = []
    while trailers.empty?
      movie = self.get_movie(page_count)
      trailers = movie["trailers"]["youtube"]
    end
    build_movie(movie)
  end
end

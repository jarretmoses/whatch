require 'open-uri'
require 'pry'

class Movie < ActiveRecord::Base
  has_many :ratings
  has_many :users, through: :ratings

  def get_amazon_link
    doc = Nokogiri::HTML(open("http://www.imdb.com/title/#{self.imdb_id}"))
    if (!doc.css("section#watchbar2 a").empty?)
      "http://www.imdb.com" + doc.css("section#watchbar2 a").attr("href").value
    else
      nil
    end
  end

  def self.page_count
    result = JSON.parse(open("https://api.themoviedb.org/3/discover/movie?api_key=#{ENV['MOVIE_API']}&sort_by=vote_average.desc&vote_count.gte=15&vote_average.gte=7.5&page=1").read)
    return result["total_pages"]
  end

  def self.get_movie(page_count)
    random_num = rand(page_count) + 1
    result = JSON.parse(open("https://api.themoviedb.org/3/discover/movie?api_key=#{ENV['MOVIE_API']}&sort_by=vote_average.desc&vote_count.gte=15&vote_average.gte=7.5&page=#{random_num}").read)
    #refactor into two mehtods: get random page & get random movie from page)
    movie_id = result["results"].sample["id"]
    JSON.parse(open("https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{ENV['MOVIE_API']}&append_to_response=trailers").read)
  end

  def self.build_movie(result)
    #taking the first genre of the movie
    genre     = result["genres"][0]["name"]
    title     = result["title"]
    rating    = result["vote_average"]
    imdb_id   = result["imdb_id"]
    source_id = result["trailers"]["youtube"][0]["source"]
    poster    = "http://image.tmdb.org/t/p/w500" + result["poster_path"]

    parameters = {title: title, genre: genre, rating: rating, imdb_id: imdb_id, source_id: source_id, poster: poster}

    self.find_or_create(parameters)
  end

  def self.find_or_create(parameters)
    self.find_by(imdb_id: parameters["imdb_id"]) || self.create(parameters)
  end

  def self.pick_movie
    trailers = []
    movie = self.get_movie(page_count)
    while trailers.empty? || (Movie.find_by(imdb_id: movie["imdb_id"]).users.include?(current_user) if Movie.find_by(imdb_id: movie["imdb_id"]))
      movie = self.get_movie(page_count)
      trailers = movie["trailers"]["youtube"]
    end
    build_movie(movie)
  end
end

class MoviesController < ApplicationController  
  def index
    @movie = Movie.pick_movie
  end
end

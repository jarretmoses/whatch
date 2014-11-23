class MoviesController < ApplicationController  
  def index
    @movie = Movie.pick_movie
  end

  def watch
  	@movie = Movie.find(params[:id])
  	@link = @movie.get_amazon_link

  end
end

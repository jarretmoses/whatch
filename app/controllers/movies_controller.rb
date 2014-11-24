class MoviesController < ApplicationController  
  def index
    @movie = Movie.pick_movie
    while @movie.users.include?(current_user)
      @movie = Movie.pick_movie
    end
  end

  def watch
  	@movie = Movie.find(params[:id])
  	@link = @movie.get_amazon_link

  end
end

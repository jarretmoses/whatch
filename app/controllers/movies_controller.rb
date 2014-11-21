class MoviesController < ApplicationController  
  def index
    @movie = Movie.pick_movie
  end

  def watch
  	@movie = Movie.find(params[:id])
  	link = @movie.get_amazon_link

  	if link
  		redirect_to link
  	else
  		redirect_to :back
  	end
  end
end

class RatingsController < ApplicationController
  def create
    Rating.create(user_id: current_user.id, movie_id: params[:movie_id], score: params[:score])    
    @movie = Movie.pick_movie
  end

  def index
    @ratings_yes = Rating.where(user_id: current_user.id, score: 2, watched: 0)
    @ratings_maybe = Rating.where(user_id: current_user.id, score: 1, watched: 0)
  end

  def update
  	@rating = Rating.find(params[:id])
  	@rating.watched = true
  	@rating.save

  end

  def destroy
  	@rating = Rating.find(params[:id])
  	@rating.destroy
 
  	render 'update.js.erb'
  end

end

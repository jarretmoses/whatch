class RatingsController < ApplicationController
  def create
    Rating.create(user_id: current_user.id, movie_id: params[:movie_id], score: params[:score])
    
    redirect_to root_path
  end

  def index
    @ratings_yes = Rating.where(user_id: current_user.id, score: 2, watched: 0)
    @ratings_maybe = Rating.where(user_id: current_user.id, score: 1, watched: 0)
  end

end

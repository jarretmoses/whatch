class RatingsController < ApplicationController
  def create
    raise params.inspect
    Rating.create(user_id: 1, movie_id: params[:movie_id], score: params[:score])
    
    redirect_to root_path
  end

  def index
    @ratings_yes = Rating.where(user_id: 1, score: 2, watched: 0)
    @ratings_maybe = Rating.where(user_id: 1, score: 1, watched: 0)
  end

end

class RatingsController < ApplicationController
  def create
    Rating.create(user_id: 1, movie_id: params[:movie_id], score: params[:score])
    
    redirect_to root_path
  end

end

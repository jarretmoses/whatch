class RatingsController < ApplicationController
  def create
    if !Rating.find_by(user_id:current_user.id, movie_id:params[:movie_id])
      Rating.create(user_id: current_user.id, movie_id: params[:movie_id], score: params[:score])    
      @movie = Movie.pick_movie
      while @movie.users.include?(current_user)
        @movie = Movie.pick_movie
      end
    end
  end

  def index
    @ratings_yes = Rating.where(user_id: current_user.id, score: 2, watched: false)
    @ratings_maybe = Rating.where(user_id: current_user.id, score: 1, watched: false)
    @ratings_all = @ratings_yes + @ratings_maybe
    @genres = Genre.order(name: :asc)
  end

  def update
  	@rating = Rating.find(params[:id])
  	@rating.watched = true
  	@rating.save
    @client.update("I just whatched #{@rating.movie.title} @WHATCHapp")
    
  end

  def destroy
  	@rating = Rating.find(params[:id])
  	@rating.destroy
 
  	render 'update.js.erb'
  end

end

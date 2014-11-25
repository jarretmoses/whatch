class RatingsController < ApplicationController

  before_action :get_ratings, only: [:index, :lucky]

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

  def lucky
    @choice = @ratings_all.sample
    @ratings_all.delete(@choice)
    while !@ratings_all.empty? && !@choice.movie.get_amazon_link
      @choice = @ratings_all.sample
      @ratings_all.delete(@choice)
    end
    if @choice
      redirect_to @choice.movie.get_amazon_link
    else
      redirect_to error_path
    end
  end

  private

    def get_ratings
      @ratings_yes = Rating.where(user_id: current_user.id, score: 2, watched: false)
      @ratings_maybe = Rating.where(user_id: current_user.id, score: 1, watched: false)
      @ratings_all = @ratings_yes + @ratings_maybe
    end

end

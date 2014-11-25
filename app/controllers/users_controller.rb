class UsersController < ApplicationController
  def email
    yes = Rating.where(user_id: current_user.id, score: 2, watched: false)
    maybe = Rating.where(user_id: current_user.id, score: 1, watched: false)
    ListMailer.list_email(params[:email],yes,maybe).deliver   
  end
end

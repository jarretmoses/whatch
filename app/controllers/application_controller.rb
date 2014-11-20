class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 
  private
  
	  def log_in(user)
	    session[:user_id] = user.id
	  end

		def log_out
	    session.delete(:user_id)
	    @current_user = nil
	  end

	  def current_user
		  @current_user ||= User.find_by(id: session[:user_id])
		end
		helper_method :current_user

end

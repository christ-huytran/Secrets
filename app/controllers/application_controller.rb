class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	def current_user
		User.find session[:id] if session[:id]
	end

	def require_login
		redirect_to '/sessions/new' if session[:id] == nil
	end

	def require_correct_user
		user = User.find params[:id]
		redirect_to "/users/#{current_user.id}" if current_user != user
	end

	def unlike_button(user, secret)
		Like.where(user: user, secret: secret)
	end

	helper_method :current_user, :unlike_button
end

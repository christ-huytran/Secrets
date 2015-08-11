class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by email: params[:email]
		if user && user.authenticate(params[:password])
			session[:id] = user.id
			session[:name] = user.name
			redirect_to "/users/#{user.id}"
		else
			flash[:error] = 'Invalid'
			redirect_to "/sessions/new"
		end
	end

	def destroy
		session.clear
		redirect_to "/sessions/new"
	end
end
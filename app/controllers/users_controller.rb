class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create]
	before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

	def new
	end

	def create
		user = User.new
		user.name = params[:name]
		user.email = params[:email]
		user.password = params[:password]
		user.password_confirmation = params[:password_confirmation]
		if user.save
			# redirect_to "/users/#{user.id}"
			redirect_to '/sessions/new'
		else
			flash[:errors] = user.errors.full_messages
			redirect_to '/users/new'
		end
	end

	def show
		@user = User.find params[:id]
		@secret = Secret.new
	end

	def edit
		@user = User.find params[:id]
	end

	def update
		user = User.find params[:id]
		user.name = params[:name]
		user.email = params[:email]
		session[:name] = user.name
		if user.save
			redirect_to "/users/#{user.id}"
		else
			flash[:errors] = user.errors.full_messages
			redirect_to "/users/#{user.id}/edit"
		end		
	end

	def destroy
		user = User.find params[:id]
		user.destroy
		session.clear
		redirect_to '/sessions/new'
	end
end

class LikesController < ApplicationController

	def create
		@user = User.find params[:like][:user_id]
		@secret = Secret.find params[:like][:secret_id]		
		Like.create(user: @user, secret: @secret)
		redirect_to "/secrets"
	end

	def destroy
		like = Like.find params[:id]
		like.destroy if like.user == current_user
		redirect_to "/secrets"
	end

end

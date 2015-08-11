class SecretsController < ApplicationController
	before_action :require_login, only: [:index, :create, :destroy]

	def index
		@secrets = Secret.all
	end

	def create
		Secret.create(secret_params)
		redirect_to "/users/#{session[:id]}"
	end

	def destroy
		secret = Secret.find params[:secret][:id]
		secret.destroy if secret.user == current_user
		redirect_to "/users/#{session[:id]}"
	end

	private 
		def secret_params
			params.require(:secret).permit(:content, :user_id)
		end
end

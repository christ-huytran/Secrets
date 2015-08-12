require 'rails_helper'

RSpec.describe LikesController, type: :controller do

	before do
		@user = create_user
		@secret = @user.secrets.create(content: "secret")
	end

	controller(SecretsController) do
		def index
		end

		def destroy
			like = Like.find params[:id]
			like.destroy if like.user == current_user
			redirect_to "/secrets"
		end
	end

	describe 'not logged in' do
		before do
			session[:id] = nil
		end

		it 'can neither like nor unlike' do
			get :index
			expect(response).to redirect_to("/sessions/new")
		end
	end

	describe 'when logged in as the wrong user' do
		before do
			@wrong_user = create_user 'julius', 'julius@lakers.com'
			session[:id] = @wrong_user.id
			@like = Like.create(user: @user, secret: @secret)
			get :index
		end

		it 'cannot unlike' do
			delete :destroy, id: @like.id
			expect(response).to redirect_to("/secrets")
		end
	end
end

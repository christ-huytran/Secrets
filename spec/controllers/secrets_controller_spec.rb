require 'rails_helper'
RSpec.describe SecretsController, type: :controller do
	before do
		@user = create_user
		@secret = @user.secrets.create(content: "secret")
	end

	describe "when not logged in" do
		before do
			session[:id] = nil
		end

		it "cannot access index" do
			get :index
			expect(response).to redirect_to('/sessions/new')
		end

		it "cannot access create" do
			post :create
			expect(response).to redirect_to('/sessions/new')
		end

		it "cannot access destroy" do
			delete :destroy, id: @secret
			expect(response).to redirect_to('/sessions/new')
		end
	end

	describe "when logged in as the wrong user" do
		before do
			@wrong_user = create_user 'julius', 'julius@lakers.com'
			session[:id] = @wrong_user
			@secret = @user.secrets.create(content: 'Ooops')
		end

		it "cannot access destroy" do
			delete :destroy, secret: {id: @secret}, id: @user
			expect(response).to redirect_to("/users/#{@wrong_user}")
		end
	end
end
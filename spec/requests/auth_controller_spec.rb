require 'rails_helper'

RSpec.describe AuthController, type: :request do
	describe 'GET #login' do
		context "when user is not logged in" do
			it "renders login page" do
				get login_path

				expect(response).to render_template(:new)
			end
		end

		context "when user is logged in" do
			let(:user) { create(:user) }

			before(:each) do
				login(user)
			end

			it "redirects to app page" do
				get login_path

				expect(response).to redirect_to(app_path)
			end
		end
	end

	describe 'POST #login' do
		context "when user is not logged in" do
			context "and user does not exist" do
				it "renders login page" do
					post login_path, params: { login: { email: 'test@test.xxy', password: 'password', password_confirmation: "password" } }

					expect(response).to render_template(:new)
				end
			end

			context "and user does exist" do
				let(:user) { create(:user) }

				context "and password is incorrect" do
					it "render login page" do
						post login_path, params: { login: { email: user.email, password: 'password1', password_confirmation: "password1" } }

						expect(response).to render_template(:new)
					end
				end

				context "and password is correct" do
					it "redirects to app page" do
						post login_path, params: { login: { email: user.email, password: user.password, password_confirmation: user.password } }

						expect(response).to redirect_to(app_path)
					end
				end
			end
		end
	end

	describe "GET #logout" do
		context "when user is not logged in" do
			it "redirects to root path" do
				get logout_path

				expect(response).to redirect_to(root_path)
			end
		end

		context "when user is logged in" do
			let(:user) { create(:user) }

			before(:each) do
				login(user)
			end

			it "redirects to root path" do
				get logout_path

				expect(request.session['user_id']).to be_nil
				expect(response).to redirect_to(root_path)
			end
		end
	end
end
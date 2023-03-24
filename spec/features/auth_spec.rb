require 'rails_helper'

RSpec.feature "Auth", type: :feature do
	describe "opening login page" do
		context "when user is logged in" do
			let(:user) { create(:user) }

			before(:each) do
				login_in_feature_spec(user)
			end

			it "redirects to app path" do
				visit login_path
				expect(current_path).to eq(app_path)
			end
		end

		context "when user is not logged in" do
			let(:user) { create(:user) }

			it "renders login page" do
				visit login_path
				expect(current_path).to eq(login_path)
			end

			it "allows to log in" do
				visit login_path
				fill_in "Email", with: user.email
				fill_in "Password", with: user.password
				click_button "Log in"

				expect(current_path).to eq(app_path)
			end
		end
	end

	describe "opening logout page" do
		context "when user is not logged in" do
			it "redirects to root page" do
				visit logout_path
				expect(current_path).to eq(root_path)
			end
		end

		context "when user is logged in" do
			let(:user) { create(:user) }

			before(:each) do
				login_in_feature_spec(user)
			end

			it "allows to log out" do
				visit logout_path

				expect(current_path).to eq(root_path)
			end
		end
	end

	describe "opening signup page" do
		context "when user is logged in" do
			let(:user) { create(:user) }

			before(:each) do
				login_in_feature_spec(user)
			end

			it "redirects to app path" do
				visit signup_path

				expect(current_path).to eq(app_path)
			end
		end

		context "when user is not logged in" do
			subject{ build(:user_with_people) }

			it "renders register page" do
				visit signup_path
				expect(current_path).to eq(signup_path)
			end

			it "allows to register" do
				visit signup_path

				fill_in "Email", with: subject.email
				fill_in "Password", with: subject.password
				fill_in "Confirmation", with: subject.password
				find("input[type='submit']").click

				expect(page).to have_content("User was successfully created.")

			end

			it "does not allow to delete user" do
				visit signup_path

				expect(page).to_not have_link("Delete Account")
			end
		end
	end
end
require 'rails_helper'

RSpec.describe "App", type: :feature do
	describe "allows" do
		let(:user) { build(:user) }

		before(:each) do
			login_in_feature_spec(user)
			visit app_path
		end

		it "to add more people" do
			expect(page).to have_link("New Person", href: new_person_path)
		end

		it "to log out" do
			expect(page).to have_link("Logout", href: logout_path)
		end

		it "to open account" do
			expect(page).to have_link("Open Account", href: account_path)
		end
	end
end
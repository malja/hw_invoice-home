require 'rails_helper'

RSpec.describe AddressesController, type: :request do
	describe 'GET #new' do
		context "when user is not logged in" do
			it "redirects to login page" do
				get new_person_address_path(person_id: 1)

				expect(response).to redirect_to(login_path)
			end
		end

		context "when user is logged in" do
			let(:user) { create(:user) }

			before(:each) do
				login(user)
			end

			context "and person does not exist" do
				it "redirects to person page" do
					get new_person_address_path(person_id: 1000)

					expect(response).to redirect_to(app_path)
				end
			end

			context "and person exists" do
				it "renders new address page" do
					get new_person_address_path(person_id: user.people.first.id)

					expect(response).to render_template(:new)
				end
			end
		end
	end
end
require 'rails_helper'

RSpec.describe Api::AddressesController, type: :request do
	let(:user_without_addresses) { create(:user) }
	let(:user_with_addresses) { create(:user_with_people) }

	describe "GET addresses list for person" do
		context "when person does not exist" do
			subject { user_without_addresses }

			it "returns not found" do
				get api_person_addresses_path(1000), headers: auth_header(subject)

				expect(response).to have_http_status(:not_found)
			end
		end

		context "when person exists" do
			subject { user_with_addresses }

			it "returns addresses list" do
				get api_person_addresses_path(subject.people.first), headers: auth_header(subject)

				expect(response).to have_http_status(:ok)
				expect(response.body).to eq(subject.people.first.addresses.to_json)
			end
		end
	end

	describe "GET address for person" do
		context "when person does not exist" do
			subject { user_without_addresses }

			it "returns not found" do
				get api_person_address_path(1000, 1), headers: auth_header(subject)

				expect(response).to have_http_status(:not_found)
			end
		end

		context "when person exists" do
			subject { user_with_addresses }

			context "when address does not exist" do
				it "returns not found" do
					get api_person_address_path(subject.people.first, 1000), headers: auth_header(subject)

					expect(response).to have_http_status(:not_found)
				end
			end

			context "when address exists" do
				it "returns address" do
					get api_person_address_path(subject.people.first, subject.people.first.addresses.first), headers: auth_header(subject)

					expect(response).to have_http_status(:ok)
					expect(response.body).to eq(subject.people.first.addresses.first.to_json)
				end
			end
		end
	end

	describe "POST address" do
		context "for nonexistent person" do
			subject { user_without_addresses }

			it "returns not found" do
				post api_person_addresses_path(1000), headers: auth_header(subject)

				expect(response).to have_http_status(:not_found)
			end
		end

		context "for existing person" do
			subject { user_with_addresses }

			let(:address) { build(:address_with_state) }

			context "and valid address" do
				it "creates address" do
					post api_person_addresses_path(subject), params: { person_id: subject.id, address: address }.to_json, headers: auth_header(subject)

					expect(response).to have_http_status(:created)
					expect(JSON.parse(response.body)["street"]).to eq(address.street)
				end
			end

			context "and invalid address" do
				before(:each) do
					address.street = nil
				end

				it "returns unprocessable entity" do
					post api_person_addresses_path(subject), params: { person_id: subject.id, address: address }.to_json, headers: auth_header(subject)

					expect(response).to have_http_status(:unprocessable_entity)
					expect(JSON.parse(response.body)["errors"]).to_not be_empty
				end
			end
		end
	end

end
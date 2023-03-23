require 'rails_helper'

RSpec.describe EmailsController, type: :request do
	describe "GET #new" do
		it_behaves_like "authorized endpoint", :get do
			let(:path) { new_person_email_path(1) }
		end
	end

	describe "POST #create" do
		it_behaves_like "authorized endpoint", :post do
			let(:path) { person_emails_path(1) }
		end
	end

	describe "GET #edit" do
		it_behaves_like "authorized endpoint", :get do
			let(:path) { edit_person_email_path(1, 1) }
		end
	end

	describe "PATCH #update" do
		it_behaves_like "authorized endpoint", :patch do
			let(:path) { person_email_path(1, 1) }
		end
	end

	describe "DELETE #destroy" do
		it_behaves_like "authorized endpoint", :delete do
			let(:path) { person_email_path(1, 1) }
		end
	end
end
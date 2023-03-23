require 'rails_helper'

RSpec.describe Email, type: :model do

	describe "validation" do
		subject { build(:email_with_comment) }

		it { should validate_presence_of(:email_address) }
		it { should allow_value('email@test.com').for(:email_address) }
		it { should_not allow_value('not_valid@test').for(:email_address) }
	end

	describe "associations" do
		subject { build(:email_with_comment) }
		it { should belong_to(:person) }
	end

	describe "to_s" do
		subject { build(:email_with_comment) }

		it 'returns a string' do
			expect(subject.to_s).to be_a(String)
			expect(subject.to_s).to eq("#{subject.email_address}")
		end
	end
end
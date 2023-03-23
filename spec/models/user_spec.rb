require 'rails_helper'

RSpec.describe User, type: :model do

	describe "validation" do
		subject { build(:user_with_people) }

		it { should validate_presence_of(:email) }
		it { should validate_uniqueness_of(:email) }
		it { should allow_value('email@test.com').for(:email) }
		it { should_not allow_value('not_valid@test').for(:email) }

		it { should validate_length_of(:password).is_at_least(8) }
		it { should validate_length_of(:password).is_at_most(72) }
	end

	describe "associations" do
		subject { build(:user_with_people) }

		it { should have_many(:people) }
	end

	describe "to_s" do
		subject { build(:user) }

		it 'returns a string' do
			expect(subject.to_s).to be_a(String)
			expect(subject.to_s).to eq("#{subject.email}")
		end
	end
end
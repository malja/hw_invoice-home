require 'rails_helper'

RSpec.describe Person, type: :model do

	describe "validation" do
		subject { build(:person_with_full_profile) }

		it { should validate_presence_of(:salutation) }
		it { should validate_inclusion_of(:salutation).in_array(Person.salutations.keys) }

		it { should validate_presence_of(:first_name) }
		it { should validate_presence_of(:last_name) }

		it { should allow_value('123-45-6789').for(:ssn) }
		it { should validate_length_of(:ssn).is_equal_to(9) if subject.ssn.present? }
	end

	describe "associations" do
		subject { build(:person_with_full_profile) }

		it { should have_many(:emails) }
		it { should have_many(:phone_numbers) }
		it { should have_many(:emails) }
	end

	describe "full_name" do

		context "with middle name" do
			subject { build(:person_with_middle_name) }

			it 'returns first, middle and last name' do
				expect(subject.full_name).to be_a(String)
				expect(subject.full_name).to eq("#{subject.first_name} #{subject.middle_name} #{subject.last_name}")
			end
		end

		context "without middle name" do
			subject { build(:person) }

			it 'returns first and last name' do
				expect(subject.full_name).to be_a(String)
				expect(subject.full_name).to eq("#{subject.first_name} #{subject.last_name}")
			end
		end
	end
end
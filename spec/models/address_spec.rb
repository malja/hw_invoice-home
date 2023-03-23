require 'rails_helper'

RSpec.describe Address, type: :model do

	describe "validation" do
		subject { build(:address_with_all_attributes) }

		it { should validate_presence_of(:street) }
		it { should validate_presence_of(:town) }
		it { should validate_presence_of(:zip_code) }
		it { should validate_presence_of(:country) }

		it { should validate_inclusion_of(:country).in_array(ISO3166::Country.codes) }
	end

	describe "associations" do
		subject { build(:address_with_all_attributes) }
		it { should belong_to(:person) }
	end

	describe "to_s" do
		subject { build(:address_with_all_attributes) }

		it 'returns a string' do
			expect(subject.to_s).to be_a(String)
			expect(subject.to_s).to eq("#{subject.street}, #{subject.town}, #{subject.state}, #{subject.zip_code}, #{subject.country}")
		end
	end
end
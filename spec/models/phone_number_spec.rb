require 'rails_helper'

RSpec.describe PhoneNumber, type: :model do

    describe "validation" do
        subject { build(:phone_number_with_comment) }

        it { should validate_presence_of(:phone_number) }

    end

    describe "associations" do
        subject { build(:phone_number_with_comment) }

				it { should belong_to(:person) }
    end

    describe "to_s" do
        subject { build(:phone_number_with_comment) }

				it 'returns a string' do
            expect(subject.to_s).to be_a(String)
            expect(subject.to_s).to eq("#{subject.phone_number}")
        end
    end
end
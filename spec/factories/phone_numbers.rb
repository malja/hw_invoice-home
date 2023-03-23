FactoryBot.define do
	factory :phone_number do
		phone_number { Faker::PhoneNumber.phone_number }

		association :person, factory: :person

		trait :has_comment do
			comment { Faker::Lorem.paragraph }
		end

		factory :phone_number_with_comment, traits: [:has_comment]
	end
end
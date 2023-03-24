FactoryBot.define do
	factory :address do
		street { Faker::Address.street_address }
		town { Faker::Address.city }
		zip_code { Faker::Address.zip }
		country { Faker::Address.country_code }

		trait :with_person do
			association :person, factory: :person
		end

		trait :has_state do
			state { Faker::Address.state }
		end

		factory :address_with_state, traits: [:has_state]
		factory :address_with_all_attributes, traits: [:has_state, :with_person]
	end
end
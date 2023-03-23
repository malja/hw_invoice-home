FactoryBot.define do
	factory :address do
		street { Faker::Address.street_address }
		town { Faker::Address.city }
		zip_code { Faker::Address.zip }
		country { Faker::Address.country_code }

		association :person, factory: :person

		trait :has_state do
			state { Faker::Address.state }
		end

		factory :address_with_state, traits: [:has_state]
		factory :address_with_all_attributes, traits: [:has_state]
	end
end
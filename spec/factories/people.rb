FactoryBot.define do
	factory :person do
		salutation { Person.salutations.keys.sample }
		first_name { Faker::Name.first_name }
		last_name { Faker::Name.last_name }
		ssn { Array.new(9) { Faker::Number.non_zero_digit }.join.to_i  }

		trait :has_middle_name do
			middle_name { Faker::Name.middle_name }
		end

		trait :has_birth_date do
			birth_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
		end

		trait :has_comment do
			comment { Faker::Lorem.paragraph }
		end

		trait :with_address do
			after(:create) do |person|
				create_list(:address, 3, person: person)
			end
		end

		trait :with_email do
			after(:create) do |person|
				create_list(:email, 3, person: person)
			end
		end

		trait :with_phone do
			after(:create) do |person|
				create_list(:phone_number, 3, person: person)
			end
		end

		trait :with_user do
			association :user, factory: :user
		end

		factory :person_with_middle_name, traits: [:has_middle_name]
		factory :person_with_full_profile, traits: [
			:has_birth_date, :has_birth_date, :has_comment, :with_address, :with_email, :with_phone, :with_user
		]
	end
end
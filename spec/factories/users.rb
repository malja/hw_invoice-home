FactoryBot.define do
	factory :user do

		sequence(:email) { |n| "#{n}#{Faker::Internet.email}" }

		password { Faker::Internet.password }
		password_confirmation { password }

		trait :with_people do
			after(:create) do |user|
				create_list(:person_with_full_profile, 3, user: user)
			end
		end

		factory :user_with_people, traits: [:with_people]
	end
end
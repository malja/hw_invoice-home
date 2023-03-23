FactoryBot.define do

	factory :email do
		sequence(:email_address) { |n| "#{n}#{Faker::Internet.email}" }

		association :person, factory: :person

		trait :has_comment do
			comment { Faker::Lorem.paragraph }
		end

		factory :email_with_comment, traits: [:has_comment]
	end

end
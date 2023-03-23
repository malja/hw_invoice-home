namespace :factory_bot do
	desc 'Verify FactoryBot factories'
	task verify: :environment do
		if Rails.env.test?
			DatabaseCleaner.cleaning do
				FactoryBot.lint
			end
		else
			system("bundle exec rake factory_bot:verify RAILS_ENV=test")
			fail if $?.exitstatus.nonzero?
		end
	end
end
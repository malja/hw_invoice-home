module FeatureHelper
	def login_in_feature_spec(user)
		allow_any_instance_of(ApplicationController).to receive(:current_user) { user }
	end
end
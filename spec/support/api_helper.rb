
module ApiHelper
	def auth_header(user)
		secret = Rails.application.secrets.secret_key_base
		token = ::JWT.encode({ user_id: user.id, exp: (Time.now + 24.hours).to_i }, secret)

		{
			"Authorization": "Bearer #{token}",
			"Accept": "application/json",
			"Content-Type": "application/json"
		}
	end
end

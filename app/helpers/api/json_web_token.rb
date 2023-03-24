module Api
	class JsonWebToken

		SECRET = Rails.application.secrets.secret_key_base.to_s.freeze

		def self.encode(payload, exp = 24.hours.from_now)
			payload[:exp] = exp.to_i
			::JWT.encode(payload, SECRET)
		end

		def self.decode(token)
			body = ::JWT.decode(token, SECRET)[0]
			HashWithIndifferentAccess.new body
		end

	end
end
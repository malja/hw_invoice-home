class User < ApplicationRecord

	before_create :set_active_status

	has_many :people, :dependent => :destroy

	validates :email, presence: true, uniqueness: true, format: { with: ValidatorHelper::EMAIL_REGEX }
	validates :password, length: { minimum: 8 } if :password_digest_changed?
	has_secure_password

	attribute :email, :string
	attribute :active, :boolean, default: true

	def set_active_status
		self.active = true
	end
end
class Email < ApplicationRecord
	belongs_to :person

	validates :email_address, presence: true, format: { with: ValidatorHelper::EMAIL_REGEX }

	attribute :email_address, :string
	attribute :comment, :text
end
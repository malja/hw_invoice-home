class PhoneNumber < ApplicationRecord
	belongs_to :person

	validates :phone_number, presence: true

	attribute :phone_number, :string
	attribute :comment, :text

	def to_s
		"#{phone_number}"
	end
end
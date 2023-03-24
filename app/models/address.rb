class Address < ApplicationRecord
	belongs_to :person

	validates :street, presence: true
	validates :town, presence: true
	validates :zip_code, presence: true
	validates :country, presence: true, inclusion: { in: ISO3166::Country.codes }

	attribute :street, :string
	attribute :town, :string
	attribute :zip_code, :string
	attribute :state, :string
	attribute :country, :string

	def full_address
		"#{street}, #{town}, #{state}, #{zip_code}, #{country}"
	end
end
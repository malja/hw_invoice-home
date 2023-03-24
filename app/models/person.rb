class Person < ApplicationRecord
	enum salutation: {
		mr: "Mr.",
		mrs: "Mrs.",
		ms: "Ms."
	}

	validates :salutation, presence: true, inclusion: { in: salutations.keys }
	validates :first_name, presence: true
	validates :last_name, presence: true
	validate :check_ssn, if: -> { ssn.present? }

	has_many :addresses, dependent: :destroy
	has_many :emails, dependent: :destroy
	has_many :phone_numbers, dependent: :destroy

	accepts_nested_attributes_for :addresses, allow_destroy: true
	accepts_nested_attributes_for :emails, allow_destroy: true
	accepts_nested_attributes_for :phone_numbers, allow_destroy: true

	belongs_to :user

	attribute :salutation, :string, default: "Mr."
	attribute :first_name, :string
	attribute :middle_name, :string
	attribute :last_name, :string
	attribute :ssn, :integer
	attribute :birth_date, :date
	attribute :comment, :text

	def check_ssn
		# Basic check for SSN validity. It's not perfect, but it's better than nothing.
		# https://secure.ssa.gov/apps10/poms.nsf/lnx/0110201035
		ssn_as_string = ssn_before_type_cast.to_s.gsub(/\s+|-/, "")
		#               ^ I want the original value received from the form. Typecasting would convert "123-45-6789" to 123

		errors.add("must be a number") unless ssn_as_string.to_i.is_a? Numeric

		if ssn_as_string.length != 9
			errors.add(:ssn, "is the wrong length (should be 9 characters)")
		end

		if ssn_as_string[0..2] === "000" || ssn_as_string[3..4] === "00" || ssn_as_string[5..8] === "0000"
			errors.add(:ssn, "is invalid")
		end
	end

	def full_name
		middle_name.present? ?
			"#{first_name} #{middle_name} #{last_name}" :
			"#{first_name} #{last_name}"
	end
end
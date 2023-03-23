require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do

	describe 'welcome' do
		let(:user) { build(:user) }
		let(:mail) { described_class.welcome_email(user).deliver_now }

		it 'renders the subject' do
			expect(mail.subject).to eq('Welcome to Address Book!')
		end

		it 'renders the receiver email' do
			expect(mail.to).to eq([user.email])
		end

		it 'renders the sender email' do
			expect(mail.from).to eq(['noreply@address-book.malcak.cz'])
		end

		it 'assigns @user.email' do
			expect(mail.body.encoded).to match(user.email)
		end
	end

	describe 'goodbye' do
		let(:user) { build(:user) }
		let(:mail) { described_class.goodbye_email(user).deliver_now }

		it 'renders the subject' do
			expect(mail.subject).to eq('Sad to see you go :(')
		end

		it 'renders the receiver email' do
			expect(mail.to).to eq([user.email])
		end

		it 'renders the sender email' do
			expect(mail.from).to eq(['noreply@address-book.malcak.cz'])
		end
	end
end
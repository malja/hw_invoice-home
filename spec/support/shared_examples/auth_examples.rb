RSpec.shared_examples "authorized endpoint" do |method|
	context "when user is not logged in" do
		it "redirects to login page" do
			send(method, path)

			expect(response).to redirect_to(login_path)
		end
	end
end
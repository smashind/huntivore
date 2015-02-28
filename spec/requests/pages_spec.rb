require 'rails_helper'

describe "Pages" do 

	subject { page }

	describe "Home page" do 
		before { visit root_path }
		it { should have_selector('h1', text: "Find Time to Hunt") }
	end

	let(:user) { User.create(first_name: "Joe", last_name: "Smith", email: "joe@example.com", password: "foobarrr", accepted_terms: true) }

	describe "Home page when signed in" do 
		before { sign_in user }

		it "should redirect to user's profile page" do 
			visit root_path
			expect(current_path).to eq(user_path(user))
		end
	end

end


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

	describe "Listing page" do 
		before do 
			visit listing_path
			click_link "List Your Land" 
		end

		it "should have link to the Create Account page" do 
			expect(current_path).to eq(new_user_registration_path)
		end

		it "should redirect to the new property listing on signup" do 
			fill_in "user_first_name", with: "John"
			fill_in "user_last_name",  with: "Man"
			fill_in "user_email",      with: "john@example.com"
			fill_in "user_password",   with: "foobarrr"
			fill_in "user_password_confirmation", with: "foobarrr"
			check("user_accepted_terms")
			click_button "SIGN UP (FREE)"
			expect(current_path).to eq(new_property_path)
		end

		it "should redirect to user's profile page when logged in" do 
			sign_in user
			visit listing_path
			expect(current_path).to eq(user_path(user))
		end		
	end

end
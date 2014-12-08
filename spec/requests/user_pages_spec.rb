require 'rails_helper'
require 'spec_helper'

describe 'User pages' do 

	subject { page }

	before { User.create(first_name: "Joe", last_name: "Smith", email: "joe@example.com", password: "foobarrr") }

	describe "sign in" do 
		before { visit new_user_session_path }

		describe "with valid information" do 
			before do 
				fill_in "Email",    with: "joe@example.com" 
				fill_in "Password", with: "foobarrr"
				click_button "Log in"
			end

			it "should welcome the user" do 
				expect(page).to have_content("Welcome back, Joe")
			end
		end

	end

end

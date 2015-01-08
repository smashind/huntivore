require 'rails_helper'
require 'spec_helper'

describe 'User pages' do 

	subject { page }

	describe "user registration" do 
		before do 
			visit root_path
			fill_in "user_first_name", with: "John"
			fill_in "user_last_name",  with: "Man"
			fill_in "user_email",      with: "john@example.com"
			fill_in "user_password",   with: "foobarrr"
			fill_in "user_password_confirmation", with: "foobarrr"
		end

		it "should redirect to user's page" do 
			click_button "SIGN UP (FREE)"
			expect(current_path).to eq(user_path(1))
		end
	end

	let(:user) { User.create(first_name: "Joe", last_name: "Smith", email: "joe@example.com", password: "foobarrr", twitter: "huntivore") }

  describe "user login" do 

  	it "should redirect to the user's page" do 
  		sign_in user
  		expect(current_path).to eq(user_path(user))
  	end
  end

	describe "user behavior" do 
		before { sign_in user }

		it "should welcome the user" do 
			expect(page).to have_content("Welcome back, Joe")
		end

		it "should link to the user profile from the navbar" do 
			click_link "Profile"
			expect(current_path).to eq(user_path(user))
		end

		it "should show the user's profile page" do 
			visit user_path(user)
			expect(page).to have_content("Joe Smith")
		end
	end

	describe "user profile page" do 
		before { sign_in user }

		it "should have the user's gravatar" do 
			expect(page).to have_css("img[alt='Joe Smith']")
		end

		it "should show how long the user has been a member" do 
			expect(page).to have_content("#{user.created_at.strftime("Member since %B %Y")}")
		end

		it "should have a 'Properties' list" do
			expect(page).to have_text("Properties")
		end

		it "should list the user's properties" do
			visit new_property_path
			fill_in 'Title',        with: 'Duck Hunt'
			fill_in 'Description',  with: 'A sweet place to hunt ducks'
			fill_in 'Game',         with: 'duck'
			fill_in 'Location',     with: 'Alabama'
			fill_in 'Accommodates', with: 4
		  fill_in 'Price',        with: 99
		  click_button 'Submit Property'
		  visit user_path(user)
		  expect(page).to have_link("Duck Hunt")
		end

		it "should have a list new property button" do 
			expect(page).to have_link("List Your Property")
		end

		it "should have a link to edit profile" do
			expect(page).to have_link("Edit profile")
		end

		it "should have a trips link" do 
			expect(page).to have_link("Trips")
		end

		it "should have a hosting link" do 
			expect(page).to have_link("Hosting")
		end
  end

  describe "editing user" do 
  	before do 
  		sign_in user
  		visit edit_user_registration_path
  	end

  	it { should have_content("Twitter") }
  	it { should have_content("Facebook") }
  	it { should have_content("Instagram") }
  	it { should have_content("Website") }

  	

  end


end

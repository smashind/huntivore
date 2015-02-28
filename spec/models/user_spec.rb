require 'rails_helper'

describe User do 

	before { @user = User.new(
			first_name: "John",
			last_name: "Doe",
			email: "john@example.com",
			password: "password",
	    accepted_terms: true)
	}

	subject { @user }

	it { should be_valid }
	it { should respond_to(:first_name) }
	it { should respond_to(:last_name) }
	it { should respond_to(:email) }
	it { should respond_to(:password) }

	describe "when first name is not present" do 
		before { @user.first_name = nil }
		it { should_not be_valid }
	end

	describe "when last name is not present" do 
		before { @user.last_name = nil }
		it { should_not be_valid }
	end

	describe "when email is not present" do 
		before { @user.email = nil }
		it { should_not be_valid }
	end

	describe "when password is not present" do 
		before { @user.password = nil }
		it { should_not be_valid }
	end
end
require 'rails_helper'

describe Reservation do 

	before { @reservation = Reservation.new(
			from:        '5/15/2016',
			to:          '5/20/2016',
			user_id:     1,
			property_id: 1)
  }
	
	subject { @reservation }

	it { should be_valid }
	it { should respond_to(:from) }
	it { should respond_to(:to) }
	it { should respond_to(:user_id) }
	it { should respond_to(:property_id) }

	describe "when dates are not present" do 
		before { @reservation.from = nil, @reservation.to = nil }
		it { should_not be_valid }
	end

	describe "when user id is not present" do 
		before { @reservation.user_id = nil }
		it { should_not be_valid }
	end

  describe "when property id is not present" do 
  	before { @reservation.property_id = nil }
		it { should_not be_valid }
	end
end

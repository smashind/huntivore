require 'rails_helper'

describe Reservation do 

	before do 
		property = Property.new(
			title: 'Duck Hunt',
			description: 'A sweet place to hunt ducks',
			game_list: 'boar,bear,geese',
			hunttype: 'Day',
			location: 'Alabama',
			accommodates: 4,
			price: 99,
			user_id: 1)
	  @reservation = property.reservations.new(
			from:        '5/15/2016',
			to:          '5/20/2016',
			user_id:     1,
			property_id: 1)
	end
	
	subject { @reservation }

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

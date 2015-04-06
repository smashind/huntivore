require 'rails_helper'

describe Reservation do 

	before do 
		@property = Property.new(
			title: 'Duck Hunt',
			description: 'A sweet place to hunt ducks',
			game_list: 'boar,bear,geese',
			hunttype: 'Day',
			location: 'Alabama',
			accommodates: 4,
			price: 99,
			user_id: 1)
	  @reservation = @property.reservations.new(
			from:        '5/15/2016',
			user_id:     1,
			property_id: 1,
			guests: 1)
	end
	
	subject { @reservation }

	it { should respond_to(:from) }
	it { should respond_to(:to) }
	it { should respond_to(:user_id) }
	it { should respond_to(:property_id) }
	it { should respond_to(:guests) }

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

	describe "trip price" do 
		let(:owner) { FactoryGirl.create(:user) }
    let(:guest) { FactoryGirl.create(:user) }
    
    context "on a day trip with per person pricing" do 
			it "returns the correct price" do 
				expect(@reservation.trip_price).to eq("106.92")
			end
	  end

	  let(:day_total) { FactoryGirl.create(:property, :day_total) }
	  context "on a day trip with total price" do 
	  	before { @daytotal = guest.reservations.create(from: "5/15/2016", property_id: day_total.id, guests: 4) }
      it "returns the correct price" do 
      	expect(@daytotal.trip_price).to eq("106.92")
      end
    end

    let(:overnight) { FactoryGirl.create(:property, :overnight) }
    context "on an overnight trip with per person pricing" do 
    	before { @overnight = guest.reservations.create(from: "5/15/2016", to: "5/17/2016", property_id: overnight.id, guests: 2) }
    	it "returns the correct price" do 
    		expect(@overnight.trip_price).to eq("427.68")
    	end
    end

    let(:overnight_total) { FactoryGirl.create(:property, :overnight_total) }
    context "on an overnight trip with total price" do 
    	before { @overnight_total = guest.reservations.create(from: "5/15/2016", to: "5/17/2016", property_id: overnight_total.id, guests: 2) }
    	it "returns the correct price" do 
    		expect(@overnight_total.trip_price).to eq("213.84")
    	end
    end
	end
end

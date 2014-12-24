require 'rails_helper'

describe "ReservationPages" do 

	subject { page }

	let(:user) { User.create(first_name: "Joe", last_name: "Smith", email: "joe@example.com", password: "foobarrr") }
	let(:user2) { User.create(first_name: "Gary", last_name: "Scott", email: "gary@example.com", password: "foobarrr") }
	let(:listing) { user.properties.create(title: "Duck Hunt", description: "A sweet place to hunt ducks", location: "Alabama", accommodates: 4, price: 99) }
	before { sign_in user2 }

	describe "reservation creation" do 
		before { visit property_path(listing) }

    describe "with valid dates" do 
    	before do 
    		save_and_open_page
    		select '2014/12/29', from: "From"
    		select '2014/12/30', from: "To"
    	end

    	it "should create a reservation" do 
    		expect { click_button "Reserve" }.to change(Reservation, :count).by(1)
    	end

    end

  end

end

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
  	    fill_in "reservation_from", with: '05/15/2015' 
  	    fill_in "reservation_to",   with: '05/20/2015' 
  	  end

  	  it "should create a reservation" do 
  	    expect { click_button "Reserve this Listing" }.to change(Reservation, :count).by(1)
  	  end

      it "should show on the user profile page" do 
        click_button "Reserve this Listing"
        visit user_path(user2)
        click_link "Trips"
        expect(page).to have_content("Duck Hunt")
      end

      it "should show on the owner's profile page" do 
        click_button "Reserve this Listing"
        click_link "Logout"
        sign_in user 
        click_link "Hosting"
        expect(page).to have_content("Duck Hunt")
      end
    end

    describe "with invalid characters" do 
      before do 
        fill_in "reservation_from", with: 'dkdkd'
        fill_in "reservation_to",   with: 'dkdkd'
      end

      it "should not create a reservation" do 
        click_button "Reserve this Listing"
        expect(page).to have_content("Reservation not submitted.")
      end
    end

    describe "with dates out of order" do 
      before do 
        fill_in "reservation_from", with: '05/20/2015'
        fill_in "reservation_to",   with: '05/15/2015'
      end

      it "should not create a reservation" do 
        click_button "Reserve this Listing"
        expect(page).to have_content("Reservation not submitted.")
      end
    end

    describe "with no end date" do 
      before do 
        fill_in "reservation_from", with: '05/20/2015'
      end

      it "should not create a reservation" do 
        click_button "Reserve this Listing"
        expect(page).to have_content("Reservation not submitted.")
      end
    end 

  end

end

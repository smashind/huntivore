require 'rails_helper'

describe "ReservationPages" do 

  subject { page }

  let(:user) { User.create(first_name: "Joe", last_name: "Smith", email: "joe@example.com", password: "foobarrr", accepted_terms: true) }
  let(:user2) { User.create(first_name: "Gary", last_name: "Scott", email: "gary@example.com", password: "foobarrr", accepted_terms: true) }
  let(:user3) { User.create(first_name: "Tom", last_name: "Nook", email: "tom@example.com", password: "foobarrr", accepted_terms: true) }
  let(:listing) { user.properties.create(title: "Duck Hunt", hunttype: "Overnight", description: "A sweet place to hunt ducks", game_list: "duck, hen", location: "Alabama", accommodates: 4, phone: "123 555 4567", price: 99) }
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
        first(:link, "Hosting").click
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

  describe "Reservation page" do 

    before do 
      visit property_path(listing)
      fill_in "reservation_from", with: '05/15/2015' 
      fill_in "reservation_to",   with: '05/20/2015' 
      click_button "Reserve this Listing"
    end

    it "should show to logged in reservation maker" do 
      visit reservation_path(1)
      expect(current_path).to eq(reservation_path(1))
    end

    it "should be pending" do 
      expect(page).to have_content("Pending")
    end

    it "should have a pay now button" do 
      visit reservation_path(1)
      expect(page).to have_selector(:button, "Make Your Payment Now")
    end

    it "should show to the property owner" do 
      click_link "Logout"
      sign_in user
      visit reservation_path(1)
      expect(current_path).to eq(reservation_path(1))
    end

    it "should have a cancel button" do 
      click_link "Logout"
      sign_in user
      visit reservation_path(1)
      expect(page).to have_content('Cancel')
    end

    it "should not show for a non logged in user" do 
      click_link "Logout"
      visit reservation_path(1)
      expect(current_path).to eq(new_user_session_path)
    end

    it "should not show for a different user" do 
      click_link "Logout"
      sign_in user3
      visit reservation_path(1)
      expect(page).to have_content("You don't have permission to view this page.")
    end
  end

end

require 'rails_helper' 

describe "PropertyPages" do 

	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	let(:user2) { FactoryGirl.create(:user) }
	let(:listing) { FactoryGirl.create(:property, :overnight, user_id: user.id) }
	before { sign_in user }

	describe "property creation" do 
		before { visit new_property_path }

		describe "with valid information" do 
			before do 
				fill_in 'Title',        with: 'Duck Hunt'
				fill_in 'Description',  with: 'A sweet place to hunt ducks'
				fill_in 'Game',         with: 'duck,mallard,hen'
				fill_in 'Location',     with: 'Alabama'
				fill_in 'Accommodates', with: 4
				fill_in 'Phone',        with: "444 444 4444" 
			  fill_in 'Price',        with: 99
			end

			it "should create a property" do 
				expect { click_button 'Submit Property' }.to change(Property, :count).by(1)
			end

			it "should show the success message" do 
				click_button 'Submit Property'
				expect(page).to have_content("Property was successfully added.")
			end

			it "should show the property" do 
				click_button 'Submit Property'
				expect(page).to have_content("Duck Hunt")
				expect(page).to have_content("A sweet place to hunt ducks")
			end

			it "should be listed on properties page" do
			  click_button 'Submit Property' 
				visit properties_path
				expect(page).to have_content("($99/night/person)")
			end
		end

		describe "with invalid information" do 
			before do 
				fill_in 'Title',        with: 'Duck hunt'
				fill_in 'Location',     with: 'Alabama'
				fill_in 'Accommodates', with: 4
				fill_in 'Price',        with: 99
			end

			it "should not create a property" do 
				click_button 'Submit Property'
				expect(page).to have_content("Description can't be blank")
			end

		end

		describe "without logging in" do 
			before do 
				click_link "Logout"
				visit new_property_path
			end

			it "should redirect to signup page" do 
				expect(current_path).to eq(new_user_session_path)
			end
		end

	end

	describe "property editing" do 

		it "can be edited by the owner" do
			visit edit_property_path(listing) 
			expect(page).to have_content("Editing")
		end

		it "should update with valid attributes" do
		  visit edit_property_path(listing) 
			fill_in 'Title', with: 'Human Hunt'
			click_button 'Update Property'
			expect(page).to have_content("Property was successfully updated.")
		end

		it "should not update with invalid attributes" do
		  visit edit_property_path(listing) 
			fill_in 'Title', with: nil
			click_button 'Update Property'
			expect(page).to have_content("Title can't be blank")
		end

		it "can't be edited by non owner" do 
			click_link "Logout" 
			sign_in user2
			visit edit_property_path(listing)
			expect(current_path).to eq(user_path(user2))
		end

		describe "property page" do 
			before { visit property_path(listing) }

			it "should have edit link for owner" do 
				expect(page).to have_link("Edit this property")
			end

			it "should not have an edit link for non owner or non logged in user" do 
				click_link "Logout" 
				visit property_path(listing)
				expect(page).not_to have_link("Edit property")
			end

			it "should render the edit view" do 
				click_link "Edit this property"
				expect(current_path).to eq(edit_property_path(listing))
			end
		end

	end

	describe "property deletion" do
		before { visit property_path(listing) }

		it "cannot be deleted by the owner" do 
			expect(page).to_not have_link("Delete property")
		end

		# it "destroys the property" do 
		# 	expect { click_link "Delete property" }.to change(Property, :count).by(-1)
		# end

		# it "redirects to properties path" do 
		# 	click_link "Delete property"
		# 	expect(current_path).to eq(properties_path)
		# end

		# it "shows a successfully deleted message" do 
		# 	click_link "Delete property"
		# 	expect(page).to have_content("Property was successfully deleted.")
		# end

		it "can't be deleted by non owner" do 
			click_link "Logout"
			visit property_path(listing)
			expect(page).not_to have_link("Delete property")
		end

		it "is deleted when owner is deleted" do 
			expect { user.destroy }.to change(Property, :count).by(-1)
		end

	end

	describe "property favoriting" do 

		it "can be favorited" do 
			visit property_path(listing)
			expect(page).to have_css("i.fa.fa-star-o")
		end

		it "gets favorited" do 
			expect { Favorite.new(user_id: 1, property_id: 1).to change(Favorite, :count).by(-1) }
		end

	end

	describe "property unfavoriting" do 
		before do 
			click_link "Logout"
			sign_in user2
			user2.favorites.create(property_id: listing.id)		
		end

		it "can be unfavorited" do 
			visit property_path(listing)
			expect(page).to have_css("i.fa.fa-star")
		end
	end

	describe "unpublishing property" do 
		before do 
			visit edit_property_path(listing)
			page.choose('property_available_false')
			click_button('Update Property')
			visit property_path(listing)
		end

		it "should not be reservable" do 
			expect(page).to_not have_content("Reserve this Property")
		end

		it "should not show on the properties page" do 
			visit properties_path
			expect(page).to_not have_content("Duck Hunt")
		end
	end

	describe "making price per person" do 
		before { visit property_path(listing) }

		it "should have per person pricing" do 
			expect(page).to have_content("(per person)")
		end

		it "should have nights under the reservation" do 
			expect(page).to have_css("span.days")
		end
	end

	describe "making trip price total" do 
		before do 
      visit edit_property_path(listing)
			page.choose('property_per_person_false')
			click_button('Update Property')
			visit property_path(listing)
		end

		it "price should be total" do 
			expect(page).to have_content("total")
		end
	end

	describe "making an overnight hunt" do 
		before { visit property_path(listing) }

		it "should be an overnight hunt" do 
			expect(page).to have_content("Overnight")
		end

		it "should have a to field" do 
			expect(page).to have_css("#reservation_to")
		end
	end

	describe "making a day hunt" do 
		before do 
			visit edit_property_path(listing)
			select "Day trip", from: "property[hunttype]"
			click_button('Update Property')
			visit property_path(listing)
		end

		it "should be a day trip" do 
			expect(page).to have_content("Day trip")
		end

		it "should not have a to field" do 
			expect(page).to_not have_css("#reservation_to")
		end
	end

	describe "accommodates options" do 
		before { visit property_path(listing) }

		it "should have 4 as an option" do 
			expect(page.all('select#selectUsers option').map(&:value)).to eq(%w(1 2 3 4))
		end
	end

	describe "contacting the owner" do 
		before do
		  click_link "Logout"
		  sign_in user2
			visit property_path(listing)
		end

		it "should have a link to contact the owner" do 
			expect(page).to have_content("Send #{listing.user.first_name} a Message")
		end
	end
end
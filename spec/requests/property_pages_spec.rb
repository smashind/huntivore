require 'rails_helper' 

describe "PropertyPages" do 

	subject { page }

	let(:user) { User.create(first_name: "Joe", last_name: "Smith", email: "joe@example.com", password: "foobarrr") }
	let(:user2) { User.create(first_name: "Gary", last_name: "Scott", email: "gary@example.com", password: "foobarrr") }
	let(:listing) { user.properties.create(title: "Duck Hunt", description: "A sweet place to hunt ducks", location: "Alabama", accommodates: 4, price: 99) }
	before { sign_in user }

	describe "property creation" do 
		before { visit new_property_path }

		describe "with valid information" do 
			before do 
				fill_in 'Title',        with: 'Duck Hunt'
				fill_in 'Description',  with: 'A sweet place to hunt ducks'
				fill_in 'Location',     with: 'Alabama'
				fill_in 'Accommodates', with: 4
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
				expect(page).to have_content("Duck Hunt - Alabama ($99/night)")
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
			click_button 'Submit Property'
			expect(page).to have_content("Property was successfully updated.")
		end

		it "should not update with invalid attributes" do
		  visit edit_property_path(listing) 
			fill_in 'Title', with: nil
			click_button 'Submit Property'
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
				expect(page).to have_link("Edit property")
			end

			it "should not have an edit link for non owner or non logged in user" do 
				click_link "Logout" 
				visit property_path(listing)
				expect(page).not_to have_link("Edit property")
			end

			it "should render the edit view" do 
				click_link "Edit property"
				expect(current_path).to eq(edit_property_path(listing))
			end
		end

	end

	describe "property deletion" do
		before { visit property_path(listing) }

		it "can be deleted by the owner" do 
			expect(page).to have_link("Delete property")
		end

		it "destroys the property" do 
			expect { click_link "Delete property" }.to change(Property, :count).by(-1)
		end

		it "redirects to properties path" do 
			click_link "Delete property"
			expect(current_path).to eq(properties_path)
		end

		it "shows a successfully deleted message" do 
			click_link "Delete property"
			expect(page).to have_content("Property was successfully deleted.")
		end

		it "can't be deleted by non owner" do 
			click_link "Logout"
			visit property_path(listing)
			expect(page).not_to have_link("Delete property")
		end

		it "is deleted when owner is deleted" do 
			expect { user.destroy }.to change(Property, :count).by(-1)
		end

	end


end
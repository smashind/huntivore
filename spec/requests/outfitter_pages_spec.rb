require 'rails_helper'

describe 'OutfitterPages' do 

	subject { page }

	let(:user) { FactoryGirl.create(:user, :outfitter) }
	let(:outfitter) { FactoryGirl.create(:outfitter, user_id: user.id) }
	before { sign_in user }

	describe "new outfitter user" do 
		describe "with no outfitter page" do
			it "should have a message to create a page" do
			  visit user_path(user) 
			  expect(page).to have_content("Create Your FREE Outfitter Page Here")
			end
		end

		describe "with an outfitter page" do 
			it "should not have the message if a page is already created" do 
				visit outfitter_path(outfitter)
				visit user_path(user)
				expect(page).to_not have_content("Create Your FREE Outfitter Page Here")
			end
		end
	end

	describe "outfitter page creation" do 
		before { visit new_outfitter_path }

		describe "with valid information" do 
			before do 
				fill_in 'Name',      with: 'Awesome Outfitters'
				fill_in 'About',     with: 'The awesomest outfitters in the US.'
				fill_in 'Location',  with: 'Washington'
			end

			it "should create an outfitter property" do 
				expect { click_button 'Submit outfitter page' }.to change(Outfitter, :count).by(1)
			end

			it "should show the success message" do 
				click_button 'Submit outfitter page' 
				expect(page).to have_content("Successfully added your outfitter page!")
			end

			it "should show the outfitter page" do 
				click_button 'Submit outfitter page'
				expect(page).to have_content("Awesome Outfitters")
				expect(page).to have_content("Washington")
			end
		end

		describe "without valid information" do 
			it "should not submit the outfitter page" do 
				expect { click_button 'Submit outfitter page' }.to change(Outfitter, :count).by(0)
			end

			it "should show errors with missing information" do 
				click_button 'Submit outfitter page'
				expect(page).to have_content("Name can't be blank")
				expect(page).to have_content("Description can't be blank")
				expect(page).to have_content("Location can't be blank")
			end
		end

		describe "without being logged in" do
		  before do 
		    click_link "Logout" 
		    visit new_outfitter_path
      end 

		  it "should redirect to signup page" do
		    expect(current_path).to eq(new_user_session_path)
		  end
		end

		describe "page editing" do 
			it "can be edited by the owner" do 
				visit edit_outfitter_path(outfitter)
				expect(page).to have_content("Editing Cool Outfitter")
			end

			it "should update with valid information" do 
				visit edit_outfitter_path(outfitter)
				fill_in 'Name', with: "Hot Outfitters" 
				click_button 'Update outfitter page'
				expect(page).to have_content("Successfully updated your outfitter page.")
			end

			it "should not update with invalid information" do 
				visit edit_outfitter_path(outfitter)
				fill_in 'Name', with: "" 
				click_button 'Update outfitter page'
				expect(page).to have_content("Name can't be blank")
			end

			it "can't be edited by a non owner" do 
				click_link "Logout"
				visit edit_outfitter_path(outfitter)
				expect(current_path).to eq(new_user_session_path)
			end

			describe "outfitter page" do 
				before { visit outfitter_path(outfitter) }

				it "should have an edit link for the owner" do 
					expect(page).to have_link("Edit outfitter page")
				end

				it "should not have an edit link for non owners" do 
					click_link "Logout"
					visit outfitter_path(outfitter)
					expect(page).to_not have_link("Edit outfitter page")
				end

				it "should render the edit view" do 
					click_link "Edit outfitter page" 
					expect(current_path).to eq(edit_outfitter_path(outfitter))
				end
			end
		end

		describe "owner properties" do 
			let(:property1) { FactoryGirl.create(:property, :overnight, user_id: user.id) }

			it "should show an add property button if no properties are listed" do 
			  visit outfitter_path(outfitter)
			  expect(page).to have_link("List your property or hunt")
			end

			it "should show the owner's properties" do 
				visit property_path(property1)
				visit outfitter_path(outfitter)
				expect(page).to have_content(property1.title)
			end
		end

		describe "contacting the outfitter" do 
			let(:user2) { FactoryGirl.create(:user) }

			before { click_link "Logout" }

			it "should have a contact button for non owner signed in users" do 
				sign_in user2
				visit outfitter_path(outfitter)
				expect(page).to have_button("Ask a Question")
			end

			it "should not be possible for non users" do 
				visit outfitter_path(outfitter)
				expect(page).to_not have_button("Ask a Question")
			end

			it "should tell the guest to sign in to ask a question" do 
				visit outfitter_path(outfitter)
				expect(page).to have_content("Sign in to Ask a Question")
			end
		end

	end
end

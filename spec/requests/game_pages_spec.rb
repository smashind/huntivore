require 'rails_helper'

describe "GamePages" do 

	subject { page }

  let(:user) { User.create(first_name: "Joe", last_name: "Smith", email: "joe@example.com", password: "foobarrr", accepted_terms: true) }
  let!(:property) { user.properties.create(title: "Duck Hunt", game_list: "duck, mallard, hen, dove, fox", description: "A sweet place to hunt ducks", location: "Alabama", accommodates: 4, phone: "123 555 4567", price: 99) }

  describe "index" do 

  	it "should include all tags in alphabetical order" do
      sign_in user
  		visit games_path
  		expect(page).to have_content("dove duck fox")
  	end
  end

  describe "property" do 

  	it "should include the tags" do 
  		visit property_path(property)
  		expect(page).to have_content("duck mallard hen")
  	end
  end

end
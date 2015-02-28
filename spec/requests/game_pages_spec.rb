require 'rails_helper'

describe "GamePages" do 

	subject { page }

  let(:user) { User.create(first_name: "Joe", last_name: "Smith", email: "joe@example.com", password: "foobarrr", accepted_terms: true) }

	before do 
	  user.properties.create(title: "Duck Hunt", game_list: "duck, mallard, hen", description: "A sweet place to hunt ducks", location: "Alabama", accommodates: 4, price: 99)
	end

  describe "index" do 

  	it "should include all tags in alphabetical order" do 
  		visit games_path
  		expect(page).to have_content("duck hen mallard")
  	end
  end

  describe "property" do 

  	it "should include the tags" do 
  		visit property_path(1)
  		expect(page).to have_content("duck mallard hen")
  	end
  end

end
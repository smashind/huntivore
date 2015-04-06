require 'rails_helper'

describe Property do 
	it "is valid with a title, description, type, location, price, and user id" do 
		property = Property.new(
			title: 'Duck Hunt',
			description: 'A sweet place to hunt ducks',
			game_list: 'boar,bear,geese',
			hunttype: 'day',
			location: 'Alabama',
			accommodates: 4,
			phone: '555 123 4567',
			price: 99,
			user_id: 1)
		expect(property).to be_valid
	end

	it "is invalid without a title" do 
		property = Property.new(title: nil)
		property.valid?
		expect(property.errors[:title]).to include("can't be blank")
	end

	it "is invalid without a description" do 
		property = Property.new(description: nil)
		property.valid? 
		expect(property.errors[:description]).to include("can't be blank")
	end

	it "is invalid without a location" do 
		property = Property.new(location: nil)
		property.valid?
		expect(property.errors[:location]).to include("can't be blank")
	end

	it "is invalid without any game tags" do 
		property = Property.new(game_list: "")
		property.valid?
		expect(property.errors[:game_list]).to include("can't be blank")
	end

	it "is invalid without an accommodates number" do 
		property = Property.new(accommodates: nil)
		property.valid?
		expect(property.errors[:accommodates]).to include("can't be blank")
	end

	it "is invalid without a price" do 
		property = Property.new(price: nil)
		property.valid?
		expect(property.errors[:price]).to include("can't be blank")
	end

	it "is invalid without a user id" do 
		property = Property.new(user_id: nil)
		property.valid?
		expect(property.errors[:user_id]).to include("can't be blank")
	end

	it "is invalid with a phone number" do 
		property = Property.new(phone: nil)
		property.valid?
		expect(property.errors[:phone]).to include("can't be blank")
	end

	describe "searching" do 
  	before :each do 
	    Property.create(title: 'Duck Hunt', description: 'A sweet place to hunt mallard.', game_list: 'boar,bear,geese',
			                hunttype: 'day',	location: 'Alabama', accommodates: 4,	phone: '555 123 4567', price: 99,	user_id: 1)
    end

    context "when there is a title match" do 
    	it "returns the correct number of results" do
    		result = Property.search("Duck")
    		expect(result.count).to eq(1)
    	end
    end

    context "when there is a description match" do 
    	it "returns the correct number of results" do
    		result = Property.search("mallard")
    		expect(result.count).to eq(1)
    	end
    end

    context "when there is a location match" do 
    	it "returns the correct number of results" do
    		result = Property.search("Alabama")
    		expect(result.count).to eq(1)
    	end
    end
    
    context "when there is a game match" do 
			it "returns the correct number of results" do  
				result = Property.search("boar")
				expect(result.count).to eq(1)
			end
		end

		context "when there aren't any matches" do 
    	it "returns the correct 0 results" do
    		result = Property.search("jaguar")
    		expect(result.count).to eq(0)
    	end
    end
  end

  describe "game list" do 
  	before :each do 
	    @property = Property.create(title: 'Duck Hunt', description: 'A sweet place to hunt mallard.', game_list: 'boar,boar,bear,geese',
			                            hunttype: 'day',	location: 'Alabama', accommodates: 4,	phone: '555 123 4567', price: 99,	user_id: 1)
    end

    it "includes 3 unique game" do
      total_game = @property.games.count
      expect(total_game).to eq(3)
    end
  end

end
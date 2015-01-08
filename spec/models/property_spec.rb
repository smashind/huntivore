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

end
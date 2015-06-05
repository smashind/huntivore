require 'rails_helper'

RSpec.describe Outfitter, :type => :model do
  it "is valid with a name, description, location, and user id" do 
  	outfitter = Outfitter.new(
  		name: 'Sweet Outfitters',
  		description: 'The sweetest outfitters of all time.',
  		location: 'South Dakota',
  		user_id: 1
  	)
    expect(outfitter).to be_valid
  end

  it "is invalid without a name" do 
  	outfitter = Outfitter.new(name: nil) 
  	outfitter.valid? 
  	expect(outfitter.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a description" do 
  	outfitter = Outfitter.new(description: nil)
  	outfitter.valid?
  	expect(outfitter.errors[:description]).to include("can't be blank")
  end

  it "is invalid without a location" do 
  	outfitter = Outfitter.new(location: nil)
  	outfitter.valid?
  	expect(outfitter.errors[:location]).to include("can't be blank")
  end

end

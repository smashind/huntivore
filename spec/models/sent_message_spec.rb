require 'rails_helper'

RSpec.describe SentMessage, :type => :model do
  it "is valid with a user id, property id, and body" do 
  	message = SentMessage.new(
  		user_id: 1,
  		property_id: 1,
  		recipient_id: 2,
  		body: "Hello, can I rent your hunt?")
  	expect(message).to be_valid
  end

  it "is invalid without a sender" do 
  	message = SentMessage.new(user_id: nil)
  	message.valid? 
  	expect(message.errors[:user_id]).to include("can't be blank")
  end

  it "is invalid without a body" do 
  	message = SentMessage.new(body: nil)
  	message.valid? 
  	expect(message.errors[:body]).to include("can't be blank")
  end

  it "is invalid without a recipient" do 
  	message = SentMessage.new(recipient_id: nil)
  	message.valid? 
  	expect(message.errors[:recipient_id]).to include("can't be blank")
  end

  it "is valid without a property" do 
  	message = SentMessage.new(property_id: nil)
  	message.valid?
  	expect(message.errors[:property_id]).to_not include("can't be blank")
  end
end

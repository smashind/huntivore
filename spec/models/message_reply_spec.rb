require 'rails_helper'

RSpec.describe MessageReply, :type => :model do
  it "is valid with a body" do 
  	reply = MessageReply.new(
  		user_id: 1,
  		sent_message_id: 1,
  		body: "This is the message body",
  		recipient_id: 2)
    expect(reply).to be_valid
  end

  it "is is invalid without a sender" do 
  	reply = MessageReply.new(user_id: nil)
  	reply.valid?
  	expect(reply.errors[:user_id]).to include("can't be blank")
  end

  it "is invalid without a sent message" do 
  	reply = MessageReply.new(sent_message_id: nil)
  	reply.valid? 
  	expect(reply.errors[:sent_message_id]).to include("can't be blank")
  end

  it "is invalid without a body" do 
  	reply = MessageReply.new(body: nil)
  	reply.valid?
  	expect(reply.errors[:body]).to include("can't be blank")
  end

  it "is invalid without a recipient_id" do 
  	reply = MessageReply.new(recipient_id: nil)
  	reply.valid? 
  	expect(reply.errors[:recipient_id]).to include("can't be blank")
  end
end

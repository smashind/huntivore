require 'rails_helper'

RSpec.describe ContactMessage, :type => :model do
  it "is valid with a name, email, and message" do 
  	message = ContactMessage.new(
  		name: 'John Smith',
  		email: 'john@example.com',
  		message: 'Hello pls help')
  	expect(message).to be_valid
  end
end

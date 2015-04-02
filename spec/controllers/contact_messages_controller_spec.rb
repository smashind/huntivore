require 'rails_helper'

RSpec.describe ContactMessagesController, :type => :controller do

  describe "GET #create" do
    subject { ContactMessage.create(name: "John", email: "john@example.com", message: "Hello there.") }
    
    it "should be successful" do 
      expect(response).to be_success
    end
  end

end

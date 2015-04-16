require 'rails_helper'

RSpec.describe UsersController, type: :controller do 

  describe "GET show" do
    let(:user) { FactoryGirl.create(:user) }
      
    it "returns a 301 redirect" do  
      get :show, id: user.id
      expect(response.status).to eq(301)
    end

    it "returns an SEO URL" do 
      get :show, id: user.id
      expect(response.location).to eq("http://test.host/users/#{user.id}-#{user.first_name.parameterize}-#{user.last_name.parameterize}")
    end
  end

end
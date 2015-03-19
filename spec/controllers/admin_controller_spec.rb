require 'rails_helper'

RSpec.describe AdminController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end
  end

  describe "GET users" do
    it "returns http success" do
      get :users
      expect(response).to be_success
    end
  end

  describe "GET properties" do
    it "returns http success" do
      get :properties
      expect(response).to be_success
    end
  end

  describe "GET reservations" do
    it "returns http success" do
      get :reservations
      expect(response).to be_success
    end
  end

end

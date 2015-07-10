require 'rails_helper'

RSpec.describe PagesController, :type => :controller do

  describe "GET home" do
    it "returns http success" do
      get :home
      expect(response).to be_success
    end
  end

  describe "GET faq" do
    it "returns http success" do
      get :faq
      expect(response).to be_success
    end
  end

  describe "GET contact" do
    it "returns http success" do
      get :contact
      expect(response).to be_success
    end
  end

  describe "GET list" do 
    it "returns http success" do 
      get :list
      expect(response).to be_success
    end
  end

  describe "GET special" do 
    it "returns http success" do 
      get :special
      expect(response).to be_success
    end
  end

  describe "GET listing" do 
    it "returns http success" do 
      get :listing
      expect(response).to be_success
    end

    it "renders the listing layout" do 
      get:listing
      expect(response).to render_template(layout: :listing)
    end
  end

end
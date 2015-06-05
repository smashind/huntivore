require 'rails_helper'

RSpec.describe OutfittersController, :type => :controller do

  describe "OutfittersController" do
    
    it "routes GET new" do 
      expect(:get => "outfitters/new").to route_to(
        :controller => "outfitters",
        :action => "new"
      )
    end

    it "routes GET show" do  
      expect(:get => "outfitters/1").to route_to(
        :controller => "outfitters", 
        :action => "show",
        :id => "1"
      )
    end

    it "routes POST create" do 
      expect(:post => "outfitters").to route_to(
        :controller => "outfitters",
        :action => "create"
      )
    end

    it "routes GET edit" do 
      expect(:get => "outfitters/1/edit").to route_to(
        :controller => "outfitters",
        :action => "edit",
        :id => "1"
      )
    end

    it "routes PUT update" do 
      expect(:put => "outfitters/1").to route_to(
        :controller => "outfitters",
        :action => "update",
        :id => "1"
      )
    end

    let(:outfitter) { FactoryGirl.create(:outfitter) }

    it "should be 301 redirected to full URL" do 
      get :show, id: outfitter.id
      expect(response.status).to eq(301)
    end

    it "should have an SEO URL" do 
      get :show, id: outfitter.id
      expect(response.location).to eq("http://test.host/outfitters/#{outfitter.id}-#{outfitter.name.parameterize}")
    end

  end
end

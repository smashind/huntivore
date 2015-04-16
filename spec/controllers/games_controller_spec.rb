require 'rails_helper'

RSpec.describe GamesController, type: :controller do 

	describe "GET show" do 
		let(:property) { FactoryGirl.create(:property) }
		let(:game) { property.games.first }

		it "should be 301 redirected when full URL isn't used" do 
			get :show, id: game.id
			expect(response.status).to eq(301)
		end

		it "should have an SEO URL" do 
			get :show, id: game.id
			expect(response.location).to eq("http://test.host/game/#{game.id}-#{game.name}")
		end
	end
	
end
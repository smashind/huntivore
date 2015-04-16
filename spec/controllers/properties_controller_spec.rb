require 'rails_helper'

RSpec.describe PropertiesController, :type => :controller do

	describe "property URLs" do
		let(:property) { FactoryGirl.create(:property) }

		it "returns a 301 redirect" do 
			get :show, id: property.id
			expect(response.status).to eq(301)
		end

    it "returns an SEO URL" do 
			get :show, id: property.id
			expect(response.location).to eq("http://test.host/properties/#{property.id}-#{property.title.parameterize}")
		end
	end

end 
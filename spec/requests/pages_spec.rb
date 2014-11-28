require 'rails_helper'

describe "Pages" do 

	subject { page }

	describe "Home page" do 
		before { visit root_path }
		it { should have_selector('h1', text: "Find Time to Hunt") }
	end

end


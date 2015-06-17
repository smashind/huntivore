FactoryGirl.define do
	factory :user do 
		sequence(:first_name) { |n| "First #{n}" }
		sequence(:last_name) { |n| "Last #{n}" }
		sequence(:email) { |n| "first_#{n}@example.com" }
		password "foobarrr"
		accepted_terms true

		trait :owner do 
			owner true
		end

		trait :outfitter do 
			outfitter true
		end
	end

	factory :property do
		title "Duck Hunt"
		game_list "duck,mallard"
		description "A sweet place to hunt ducks"
		location "Alabama"
		accommodates 4
		phone "123 555 4567"
		price 99
		user

		trait :overnight do 
			hunttype "Overnight"
		end

		trait :overnight_total do 
			hunttype "Overnight"
			per_person false
		end

		trait :day do 
			hunttype "Day trip"
		end

		trait :day_total do 
			hunttype "Day trip"
			per_person false
		end
	end

	factory :outfitter do 
		name "Cool Outfitter" 
		description "A really cool outfitter"
		location "Montana"
		user 
	end

end
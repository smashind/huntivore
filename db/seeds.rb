# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(first_name: 'Gary', last_name: 'Brown', email: 'garybrown@example.com', password: 'foobbarr', password_confirmation: 'foobbarr')
User.create(first_name: 'Joe', last_name: 'Black', email: 'garybrown@example.com', password: 'foobbarr', password_confirmation: 'foobbarr')
User.create(first_name: 'Anders', last_name: 'Green', email: 'garybrown@example.com', password: 'foobbarr', password_confirmation: 'foobbarr')
User.create(first_name: 'Ted', last_name: 'White', email: 'garybrown@example.com', password: 'foobbarr', password_confirmation: 'foobbarr')
User.create(first_name: 'Lisa', last_name: 'Red', email: 'garybrown@example.com', password: 'foobbarr', password_confirmation: 'foobbarr')

Property.create(title: "Duck Hunt", description: "A cool hunt for ducks haha.", game_list: "ducks", hunttype: "Overnight", location: "Austin, TX", price: 100, available: true, user_id: 1, accommodates: 4, per_person: true)
Property.create(title: "Boar and Bear Hunt", description: "You can hunt bears and boars here. It is really cool.", game_list: "bears, boars", hunttype: "Overnight", location: "Montana", price: 100, available: true, user_id: 2, accommodates: 2, per_person: true)
Property.create(title: "Shark Safari", description: "This is a safari where you can actually hunt sharks with guns (you have the guns, not them).", game_list: "shark, eel, urchin", hunttype: "Overnight", location: "Hawaii", price: 100, available: true, user_id: 2, accommodates: 4, per_person: true)
Property.create(title: "Sweet bird shooting", description: "All the beautiful birds that you can possibly hunt.", game_list: "birds", hunttype: "Overnight", location: "Anchorage Alaska", price: 200, available: true, user_id: 1, accommodates: 4, per_person: true)
Property.create(title: "Crazy Owl Hunt", description: "An amazing owl hunt. You definitely need to check it out.", game_list: "owl, eagles", hunttype: "Overnight", location: "The Owl's Nest", price: 150, available: false, user_id: 1, accommodates: 9, per_person: true)
Property.create(title: "Skeet shooting", description: "This isn't a hunt per say. Instead, you can come and shoot skeet for the day. Come out, meet some people, have fun.", game_list: "skeet", hunttype: "Day trip", location: "Visalia, CA", price: 50, available: true, user_id: 2, accommodates: 4, per_person: true)

Reservation.create(from: "1/4/2015", to: "1/8/2015", property_id: 1, user_id: 3)
Reservation.create(from: "2/5/2015", to: "2/7/2015", property_id: 2, user_id: 4)
Reservation.create(from: "3/8/2015", to: "3/11/2015", property_id: 3, user_id: 3)
Reservation.create(from: "2/11/2015", to: "2/16/2015", property_id: 4, user_id: 5)
Reservation.create(from: "4/18/2015", to: "4/19/2015", property_id: 1, user_id: 3)
Reservation.create(from: "2/24/2015", to: "2/28/2015", property_id: 2, user_id: 4)
Reservation.create(from: "2/13/2015", to: "2/14/2015", property_id: 3, user_id: 3)
Reservation.create(from: "1/4/2015", to: nil, property_id: 5, user_id: 5)
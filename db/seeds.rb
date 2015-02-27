# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Creating Users..."
User.create(:first_name => "Simão", :last_name => "Neves", :email => "simaocostaneves@gmail.com", :password => "password")
User.create(:first_name => "Rita", :last_name => "Freire", :email => "arita.freire@gmail.com", :password => "pass")
puts "Created Users successfully!"
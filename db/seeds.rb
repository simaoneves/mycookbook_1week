# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Creating Users..."
me = User.new(:first_name => "Simão", :last_name => "Neves", :email => "simaocostaneves@gmail.com", :password => "password")
me.save
User.create(:first_name => "Rita", :last_name => "Freire", :email => "arita.freire@gmail.com", :password => "pass")
puts "Created Users successfully!"


puts "Creating Recipes..."
User.all.each do |user|
  3.times do |index|
    Recipe.create(:name => "Recipe #{index}", :description => "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Molestias impedit fugiat corrupti incidunt, repellendus ut repudiandae. Placeat ad expedita accusantium fuga at, exercitationem id iste! Mollitia ad omnis, perspiciatis quae?", :visible => true, :user_id => user.id)
  end
end
puts "Created Recipes successfully!"
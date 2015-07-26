# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


30.times do
	User.create!(email: Faker::Internet.email, password: "passwordy")
	Band.create!(name: "#{Faker::Hacker.ingverb} #{Faker::Hacker.noun.pluralize}")
	Album.create!(band_id: rand(1..30),
							  rec_type: ["live", "studio"].sample, 
							  title: "#{Faker::Hacker.adjective} #{Faker::Hacker.noun}"
							  )
	Track.create!(album_id: rand(1..30), 
								track_type: ["regular", "bonus"].sample,
								title: "#{Faker::Hacker.adjective} #{Faker::Hacker.noun}")
end							
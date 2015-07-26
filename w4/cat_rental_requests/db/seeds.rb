# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
colors = %w(black white orange brown)
10.times do
  Cat.create(birth_date: Date.today - rand(1..200),
  color: colors.sample,
  name: Faker::Name.name,
  sex: %w(M F).sample,
  user_id: rand(1..10)
  )


end
10.times do
  CatRentalRequest.create(cat_id: rand(1..10),
  start_date: Date.today - rand(200..250),
  end_date: Date.today - rand(1..100),
  user_id: 1
  )
end

10.times do
  User.create(username: Faker::Internet.user_name,
  password: "foobar"
  )
end

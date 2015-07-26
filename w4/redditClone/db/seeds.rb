# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = 3.times.map do
  User.create!(username: Faker::Name.name, password: "password")
end
users << User.create!(username: "admin", password: "password")

subs = 10.times.map do
  Sub.create!(
    moderator: users.sample,
    title: Faker::Hacker.noun.pluralize,
    description: Faker::Hacker.say_something_smart
  )
end

posts = 100.times.map do
  range = 1..(subs.size / 2)
  Post.create!(
    title: Faker::Company.bs,
    content: Faker::Lorem.paragraph,
    subs: subs.sample(rand range),
    author: users.sample
  )
end

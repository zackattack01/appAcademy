# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do
  User.create!({user_name: Faker::Name.name})
end
users = User.all.to_a

5.times do
  Poll.create!({title: Faker::Commerce.department, user_id: rand(1..users.count) } )
end
polls = Poll.all.to_a

polls.each do |poll|
  3.times do
    Question.create!({ question_body: "#{Faker::Company.catch_phrase}?", poll_id: poll.id })
  end
end
questions = Question.all.to_a

questions.each do |question|
  rand(3..5).times do
    AnswerChoice.create!({ question_id: question.id,
        answer_choice: Faker::Commerce.product_name })
  end
end

users.each do |user|
  questions.each do |question|
    Response.create!({ user_id: user.id,
      answer_choice_id: question.answer_choices.sample.id })
  end
end

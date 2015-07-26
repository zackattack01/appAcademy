class Instructor < ActiveRecord::Base
  has_many(
    :courses,
    foreign_key: :instructor_id,
    primary_key: :id,
    class_name: 'Course'
  )
end

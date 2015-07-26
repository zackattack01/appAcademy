require 'set'

class Student 
  attr_reader :name
  attr_accessor :courses

  def initialize(first_name, last_name)
    @name= "#{first_name.capitalize} #{last_name.capitalize}"
    self.courses = Set.new []
  end

  def enroll(course)
    if has_conflict? course
      raise "No time-turners currently available for rental" 
    else
      courses << course
      course.add_student(self)
    end
  end

  def course_load
    course_info = {}
    courses.group_by{ |course| course.dept }.each do |group, course_attrs|
      hours= 0
      course_attrs.each{ |course| hours += course.credit_hours }
      course_info[group] = hours
    end
    course_info
  end

  def has_conflict?(desired_course)
    courses.any?{ |course| course.conflicts_with? desired_course }
  end

end












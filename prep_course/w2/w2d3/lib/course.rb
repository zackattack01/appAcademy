require 'set'

class Course
	attr_reader :name, :dept, :credit_hours
	attr_accessor :students, :days, :block
	WEEKDAYS = %i{ m t w tr f }.to_set

	def initialize(name, department, credit_hours, days=[], block=0)
		@name = name
		@dept = department
		@days = WEEKDAYS & days 
		@block = block
		@credit_hours = credit_hours
		self.students = Set.new []
	end

	def add_student(student)
		students << student
	end

	def conflicts_with?(other)
		days.any? do |day|
			other.days.any? do |other_day|
				day == other_day && block == other.block
			end
		end
	end

end
require "student"
require "course"
require "set"

describe Course do 

  attr_accessor :student

  before do
    @student = Student.new("harry", "potter")
    @alchemy= Course.new("Alchemy101", "ALCH", 3, %i{ m w f }, 3)
    @divination= Course.new("Divination101", "DIVI", 3, %i{ m tr }, 3)
  end

  it "#students should return a list of the enrolled students" do
    @student.enroll(@alchemy)
    expect(@alchemy.students).to eq [@student].to_set
  end

  it "takes a set of week days and a time block" do 
    expect(@alchemy.days).to eq [:m, :w, :f].to_set
    expect(@alchemy.block).to eq 3
  end

  it "#conflicts_with? checks for time-conflict and returns true/false" do
    arithmancy = Course.new("Arithmancy101", "ARIT", 4, %i{ t tr }, 4)
    expect(@alchemy.conflicts_with? @divination).to eq true
    expect(@alchemy.conflicts_with? arithmancy).to eq false
  end


end

describe Student do

  attr_accessor :student
  CORE_COURSES=["Astronomy","Charms","Dark Arts",
    "Defence Against the Dark Arts","Flying",
    "Herbology","History of Magic","Muggle Studies",
    "Potions","Transfiguration"]
  
  before do
    @student = Student.new("harry", "potter")
  end

  it "#name should return student's first and last name" do 
    expect(@student.name).to eq("Harry Potter")
  end

  it "#courses should return a list of student's courses" do 
    
    course_list= [].to_set
    CORE_COURSES.each do |class_name|
        course= Course.new("#{class_name}101",
          "#{class_name[0..3].upcase}",[3,4].sample)
        @student.enroll(course) 
        course_list << course
    end
    expect(@student.courses).to eq course_list
  end
  
  it "#enroll should add course to student's courses, "+
    "update course roster, and ignore repeat enrollments" do

    elective= Course.new("Alchemy101", "ALCH", 3)
    3.times{ @student.enroll(elective) }
    expect(@student.courses.include?(elective)).to eq true
    expect(elective.students.include?(@student)).to eq true
    expect(@student.courses.count(elective)).to eq 1
    expect(elective.students.count(@student)).to eq 1
  end

  it "#course_load should return a hash of departments to # of dept credits" do 
    
    dept_courseload= {}
    CORE_COURSES.each do |class_name|
        course= Course.new("#{class_name}101",
          "#{class_name[0..3].upcase}",[3,4].sample)
        @student.enroll(course) 
        dept_courseload[course.dept]= course.credit_hours
    end
    expect(@student.course_load).to eq dept_courseload
  end

  it "#enroll should raise error if there's a scheduling "+
      "conflict using #has_conflict?" do

    course= Course.new("Alchemy101", "ALCH", 3, %i{ m w f }, 3)
    desired_course1= Course.new("Arithmancy101", "ARIT", 4, %i{ m w f }, 4)
    desired_course2= Course.new("Divination101", "DIVI", 3, %i{ m tr }, 3)
    @student.enroll(course)
    expect(@student.has_conflict? desired_course1).to eq false
    expect(@student.has_conflict? desired_course2).to eq true
    expect { 
      @student.enroll desired_course2 
      }.to raise_error "No time-turners currently available for rental"
  end


end


class Bootcamp
  def initialize(name, slogan, student_capacity)
    @name = name
    @slogan = slogan
    @student_capacity = student_capacity
    @teachers = []
    @students = []
    @grades = Hash.new { |hash, key| hash[key] = [] }
  end

  def name
    @name
  end

  def slogan
    @slogan
  end

  def teachers
    @teachers
  end

  def students
    @students
  end

  def hire(teacher)
    @teachers << teacher
  end

  def enroll(student)
    if @students.length < @student_capacity
          @students << student
          return true
    else
      return false
    end
  end

  def enrolled?(student)
    @students.include?(student)
  end

  def student_to_teacher_ratio
    @students.count / @teachers.count
  end

  def add_grade(student, grade)
    if self.enrolled?(student)  #ask instructor clearify .self vs...
        @grades[student] << grade
        return true
    else  
        return false
    end
  end

  def num_grades(student)
    @grades[student].count
  end

  def average_grade(student)
    return nil if num_grades(student) == 0

    @grades[student].sum / num_grades(student)
  end 
end


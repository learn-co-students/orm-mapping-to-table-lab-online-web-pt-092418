require 'pry'
class Student
attr_accessor :name, :grade
attr_reader :id
  def initialize (name, grade, id = nil)
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = <<SQL 
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY, 
      name TEXT, 
      grade TEXT
      )
SQL
      DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<SQL
    DROP TABLE students;
SQL
    DB[:conn].execute(sql)

end

  def save
    sql = <<SQL
      INSERT INTO students(name, grade) VALUES (?, ?)
SQL
    
    DB[:conn].execute(sql, self.name, self.grade)
   db_id =  DB[:conn].execute("SELECT id FROM students WHERE name = ?", self.name).flatten
    @id = db_id[0]
  end
  
  def self.create(student_hash)
    student= self.new(student_hash[:name], student_hash[:grade])
    student.save
    student
  end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
end

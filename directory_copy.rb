require "csv"
CSV.read("students.csv")

@students = [] # an empty array accessible to all methods

def input_students
  puts "Please enter the name of the students"
  puts "To finish, just hit return twice"

  # the first name
  name = STDIN.gets.chomp
  
  # while the name is not empty, repeat this code (loop)
  while !name.empty? do
    # adding the student hash to the array
    add_student(name, "april")
    puts "Now we have #{@students.count} students"
    # another name from the user
    name = STDIN.gets.chomp
  end
end

def add_student(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------------------"
end

def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
  when "1"
    input_students
    puts "File was updated with new students."
  when "2"
    puts "List of the students:"
    show_students
  when "3"
    save_students
    puts "Everything was saved."
  when "4"
    load_students
    puts "Everything was loaded."
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def load_students(filename = "students.csv")
  # opening the file for reading
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    add_student(name, cohort)
  end
  file.close
end

def save_students
  puts "Which file do you want to use?"
  file = File.open(STDIN.gets.chomp, "w")

  #iterating over the array of students
  @students.each do |student|
    student_data = [student [:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def try_load_students
  filename = ARGV.first # the first argument from the command line
  return if filename.nil? # stop here if filename isn't given
  if File.exist?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exists
    put "Sorry, #{filename} doesn't exist."
    exit # exit the program
  end
end

try_load_students
interactive_menu
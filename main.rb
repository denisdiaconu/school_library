require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'classroom'
require_relative 'book'
require_relative 'rental'

class App
    attr_accessor :people, :books

    def initialize()
        @people = []
        @books = []
        @rentals = []
    end

    def start_point()
        choice_menu = menu_layout()
        puts choice_menu

        case choice_menu
        when 1
            list_books
        when 2
            list_people
        when 3
            create_person
        when 4
            create_book
        when 5
            create_rental
        when 6
            list_rentals_by_id
        when 7
            puts 'Thank you for using this app!'
        end
    end

    def right_choice()
        choice = gets.chomp.to_i
        if( [1,2,3,4,5,6,7].include?(choice))
            choice
        else
            puts 'Please enter a number between 1 and 7:'
            right_choice()
        end
    end

    def right_choice_2()
        answer = gets.chomp.to_i
        
        case answer
        when 1
            create_student
        when 2
            create_teacher
        else
            puts 'Please choice a number between 1 and 2:'
            right_choice_2
        end
    end

    def right_choice_3()
        permission = gets.chomp.downcase

        case permission
        when 'y'
            true
        when 'n'
            false
        else
            puts 'Please choose Y/N:'
            right_choice_3
        end
    end

    def menu_layout()
        options = [
            '1 - List all books',
            '2 - List all people',
            '3 - Create a person',
            '4 - Create a book',
            '5 - Create a rental',
            '6 - List all rentals for a given person id',
            '7 - Exit'
        ]

        puts 'Please choose an option by entrin a number:'
        puts options
        right_choice()
    end

    def create_person()
        puts 'Do you want to create a student (1) or a teacher (2)? [Input the number]:'
        right_choice_2
    end

    def create_student()
        print 'Age:'
        age = gets.chomp.to_i
        puts '- - - -'
        print 'Name:'
        name = gets.chomp
        puts '- - - -'
        print 'Has parent permission? [Y/N]:'
        permission = right_choice_3()

        print 'Classroom:'
        classroom = gets.chomp

        student = Student.new(name: name, classroom: classroom, age: age, parent_permission: permission)
        @people << student
        puts 'Person created successfully'
        start_point
    end

    def create_teacher()
        print 'Age:'
        age = gets.chomp.to_i
        puts '- - - -'
        print 'Name:'
        name = gets.chomp
        puts '- - - -'
        print 'Specialization:'
        specialization = gets.chomp

        teacher = Teacher.new(specialization: specialization, age: age, name: name)
        @people << teacher
        puts 'Person created successfully'
        start_point
    end

    def list_people()
        @people.each do |key|
            puts "[#{key.class}] Name: #{key.name}, ID: #{key.id}, Age: #{key.age}"
        end
        '0'
        puts 'Do you want to continue? [Y/N]'
        response = right_choice_3()
        response == true ? start_point : puts('Exit')
    end

    def create_book()
        print 'Title:'
        title = gets.chomp
        print 'Author:'
        author = gets.chomp

        book = Book.new(title: title, author: author)
        @books << book
        puts 'Book created successfully'
        start_point
    end

    def list_books()
        @books.each do |key|
            puts "Title: #{key.title}, Author: #{key.author}"
        end
        '0'
        puts 'Do you want to continue? [Y/N]'
        response = right_choice_3()
        response == true ? start_point : puts('Exit')
    end

    def create_rental()
        puts 'Select a book from the following list by number'
        @books.each_with_index do |b, s|
            puts "#{s}) Title: #{b.title}, Author: #{b.author}"
        end
        selection = gets.chomp.to_i
        book = @books[selection]

        puts 'Select a person from the following list by number (not id)'
        @people.each_with_index do |key, s|
            puts "#{s}) [#{key.class}] Name: #{key.name}, ID: #{key.id}, Age: #{key.age}"
        end
        selection2 = gets.chomp.to_i
        person = @people[selection2]

        print 'Date:'
        date = gets.chomp
        rental = Rental.new(date, person, book)
        @rentals << rental
        puts 'Rental created successfully'
        start_point
    end


    def list_rentals_by_id
        print 'ID of person:'
        person_id = gets.chomp
        puts 'Rentals:'
        @rentals.each do |r|
            if (r.person.id == person_id)
                puts "Date: #{r.date}, Book: #{r.book.title} by #{r.book.author}"
            end
        end
        puts 'Do you want to continue? [Y/N]'
        response = right_choice_3()
        response == true ? start_point : puts('Exit')
    end

end

def main
    puts 'Welcome to school library App!'
    puts '- - - - - - - - - - - - - - - - - - - -'
    start = App.new
    start.start_point()
end

main()
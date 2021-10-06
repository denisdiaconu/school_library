require 'securerandom'

class Person
  attr_accessor :name, :age
  attr_reader :id

  def initialize(name, age, parent_permission)
    @id = SecureRandom.uuid
    @name = name || 'Unknown'
    @age = age
    @parent_permission = parent_permission
  end

  def is_of_age?
    @age >= 18
  end

  def can_use_services?
    is_of_age? || @parent_permission ? true : false
  end
end

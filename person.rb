require 'securerandom'
require_relative 'corrector'

class Person
  attr_accessor :name, :age, :parent_permission
  attr_reader :id

  def initialize(age:, name: 'Unknown', parent_permission: true)
    @id = SecureRandom.uuid
    @name = name
    @age = age
    @parent_permission = parent_permission
    @corrector = Corrector.new
  end

  def can_use_services?
    is_of_age? || @parent_permission ? true : false
  end

  def validate_name
    @name = @corrector.correct_name(@name)
  end

  private

  def is_of_age?
    @age >= 18
  end
end

require_relative "employee"

class Manager < Employee
  attr_accessor :employees

  def initialize(name, title, salary, boss)
    super
    @employees = []
  end

  def bonus(multiplier)
    all_employees = get_all_employees
    p all_employees
    all_employees.map! {|employee| employee.salary}
    all_employees.inject(:+) * multiplier
  end

  def get_all_employees
    return self if @employees.empty?
    result = []
    @employees.each do |employee|
      if !employee.methods.include?(:employees)
        result << employee
      else
        result << employee
        result += employee.get_all_employees
      end
    end
    result
  end

end

jane = Manager.new("Jane","CEO",100_000,nil)
john = Employee.new("John", "Employee",20_000,nil)
mike = Manager.new("Mike", "Employee",200_000,nil)
amanda = Employee.new("Amanda", "Employee",80_000,nil)
justin = Employee.new("Justin", "Employee",90_000,nil)
jane.employees << john
jane.employees << mike
mike.employees << amanda
mike.employees << justin

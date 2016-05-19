class Employee
  attr_reader :salary
  def initialize(name, salary, title, boss)
    @name = name
    @salary = salary
    @title = title
    @boss = boss
    @boss.sub_employees << self unless boss.nil?
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end


class Manager < Employee
  attr_accessor :sub_employees

  def initialize(name, salary, title, boss)
    @sub_employees = []
    super
  end

  def bonus(multiplier)
    bonus = 0
    all_sub_employees.each do |emp|
      bonus += emp.salary * multiplier
    end
    bonus
  end

  def all_sub_employees
    return [] unless (@sub_employees || @sub_employees.empty?)
    subs = @sub_employees
    subs.each do |emp|
      subs += emp.all_sub_employees if emp.is_a?(Manager)
    end
    subs
  end
end

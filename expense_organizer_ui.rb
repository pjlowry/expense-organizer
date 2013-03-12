require 'active_record'
require './lib/expense'
require './lib/tag'


database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuation = database_configurations["development"]
ActiveRecord::Base.establish_connection(development_configuation)

def welcome
  puts "Welcome to the Expense Organizer!"
  menu
end

def menu
  choice = nil
  until choice == 'e'
    puts "Press 'a' to add an expense, 'l' to list your expenses by category."
    puts "Press 'e' to exit."
    choice = gets.chomp
    case choice
    when 'a'
      add
    when 'l'
      list
    when 'e'
      exit
    else
      invalid
    end
  end
end

def validate(record)
  if record.save
    puts "'#{record.description}' has been added to your Expense Organizer."
    true
  else
    puts "There was something wrong with your data. Possible errors:"
    record.errors.full_messages.each { |message| puts "   #{message}"}
    false
  end  

end

def add
  puts "Please enter the date of the expense (MM-DD-YYYY)"
  date = Date.parse(gets.chomp)
  expense_date = "#{date.month}-#{date.day}-#{date.year}"
  puts "Your date has been normalized to: #{expense_date}."
  puts "Please enter the price of the expense"
  price = gets.chomp
  puts "Please enter the description of the expense"
  description = gets.chomp
  expense = Expense.new(:expense_date => expense_date, :price => price, :description => description)
  add unless validate(expense)
end

def list
  puts "Here is a list of all your expenses:"
  expenses = Expense.all
  expenses.each {|expense| puts "    #{expense.expense_date} | #{expense.description} | #{expense.price}"}
end

welcome
require 'active_record'
require './lib/expense'
require './lib/tag'
require './lib/money'


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
    puts "Press 'a' to add an expense, 'l' to list all your expenses, 't' to find expenses by timeframe, 'c' to find by category."
    puts "Press 'e' to exit."
    choice = gets.chomp
    case choice
    when 'a'
      add
    when 'l'
      list(Expense.all)
    when 't'
      list_by_time
    when 'c'
      list_by_category
    when 'e'
      exit
    else
      invalid
    end
  end
end

def errors(record)
  if record.save
    puts "'#{record.description}' has been added to your Expense Organizer."
    false
  else
    puts "There was something wrong with your data. Possible errors:"
    record.errors.full_messages.each { |message| puts "   #{message}"}
    true
  end  

end

def add
  puts "Please enter the date of the expense (DD-MM-YYYY)"
  date = Date.parse(gets.chomp)
  expense_date = "#{date.day}-#{date.month}-#{date.year}"
  puts "Your date has been normalized to: #{expense_date}."
  puts "Please enter the price of the expense"
  price = Money.new(gets.chomp.to_f.round(2))
  puts "Please enter the description of the expense"
  description = gets.chomp
  expense = Expense.new(:expense_date => expense_date, :price => price, :description => description)
  if errors(expense)
    add
  else
    puts "What would you like to tag this?"
    tag_name = gets.chomp
    until tag_name != ''
      puts "NO! That will screw things up!"
      tag_name = gets.chomp
    end
    tag = expense.tags.create!(:name => tag_name)
  end
end
#      Money.new(gets.chomp.to_f.round(2))

def list(expenses)
  puts "Here is a list of all your expenses:"
  expenses.each {|expense| puts "    #{expense.expense_date} | #{expense.description} | #{Money.display(expense.price)} | #{expense.tags.first.name} | #{expense.percentage_of(expenses,expense)}"}
  #puts expenses.first.tags
end

def list_by_time
  puts "What is the earliest time you would like to see? (DD-MM-YYYY)"
  earliest_date = Date.parse(gets.chomp)
  puts "What is the latest time you would like to see? (DD-MM-YYYY)"
  latest_date = Date.parse(gets.chomp)
  time_frame = Expense.where("expense_date >= ? AND expense_date <= ?", earliest_date, latest_date)
  list(time_frame)
end

def list_by_category
  puts "Here are all your existing tags:"
  tags = Tag.all
  tags.each_with_index {|tag, i| puts "  #{i+1}. #{tag.name}"}
  puts "Which tags would you like to search for?"
  tag_number = gets.chomp.to_i
  tag = tags[tag_number-1]
  puts "Here are all the expenses for that tag:"
  list(Expense.where(:id => tag.expense_id))
end

def invalid
  puts "Not a valid entry."
end

welcome
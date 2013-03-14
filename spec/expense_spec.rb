require 'spec_helper'

describe Expense do
  context 'validations' do
    it {should validate_presence_of :description}
    it {should validate_presence_of :price}
    it {should validate_presence_of :expense_date}
    it {should_not allow_value("23$#4").for(:description)}
    it {should allow_value("4 cookies").for(:description)}
    it {should ensure_length_of(:description).
          is_at_least(3).
          is_at_most(100)}
    it {should_not allow_value("345756").for(:expense_date)}      
    it {should allow_value("12/12/2012").for(:expense_date)} 


  end

  context 'associations' do
    it {should have_many(:tags)}
  end

  context 'callbacks' do
    it 'converts the description to lowercase' do
      expense = FactoryGirl.build :expense
      original_description = expense.description
      expense.save
      expense.description.should eq original_description.downcase
    end
  end

  context '.percentage_of' do
    it 'provides a percentage of an expense as compared to all expenses' do
      expenses = (1..5).to_a.map { |expense| FactoryGirl.create :expense}
      tags = (1..5).to_a.map { |tag| FactoryGirl.create :tag }
      expenses.each_with_index { |expense,i| expense.update_attributes(:tags => [tags[i]]) }      
      expenses_total = expenses.inject(0) { |total,expense| total += expense.price }
      expense = expenses.first 

      "%#{(expense.price.to_f/expenses_total.to_f).round(2)*100}".should eq Expense.percentage_of(expenses,expense)
    end
  end

  context '#category_percentage_of' do
    it 'give us the percentage of an expense as compared to a specific time frame category' do
      expenses = (1..5).to_a.map { |expense| FactoryGirl.create :expense}
      tags = (1..5).to_a.map { |tag| FactoryGirl.create :tag }
      expenses.each_with_index { |expense,i| expense.update_attributes(:tags => [tags[i]]) }      
      expenses_total = expenses.inject(0) { |total,expense| total += expense.price }
      expense = expenses.first 

      "%#{(expense.price.to_f/expenses_total.to_f).round(2)*100}".should eq Expense.category_percentage_of(expenses,expense)
    end
  end
end



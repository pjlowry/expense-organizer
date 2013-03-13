require 'spec_helper'

describe Money do 
  context '#to_i' do
    it 'multiplies its float values by a hundred when placed in the database' do
      money = Money.new(3.25)
      expense = Expense.new(:expense_date => '12-12-2012', :price => money, :description => 'cow')
      expense.save
      expense.price.should eq 325
    end 
  end
  context '#to_s' do
    it 'can display itself as a money value' do
      money = Money.new(3.25)
      money.to_s.should eq '$3.25'

    end
  end
end
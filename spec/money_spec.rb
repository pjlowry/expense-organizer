require 'spec_helper'

describe Money do 
  context '#to_i' do
    it 'multiplies its float values by a hundred when placed in the database' do
      money = Money.new(3.25)
      expense = FactoryGirl.build(:expense, price: money)  
      expense.price.should eq 325
    end 
  end

  context '#to_s' do
    it 'can display itself as a money value' do
      money = Money.new(3.25)
      money.to_s.should eq '$3.25'

    end
  end

  context '.from_i' do
    it 'displays the price in $##.##' do
      Money.from_i(325).should eq '$3.25'
    end
  end
end
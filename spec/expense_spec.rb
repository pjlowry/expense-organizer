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

end
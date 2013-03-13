class Expense < ActiveRecord::Base
  has_many :tags

  validates :description, :presence => true 
  validates :description, :format => { :with => /^[a-zA-Z0-9 ]+$/}
  validates :description, :length => { :in => 3..100 }

  validates :price, :presence => true
  
  validates :expense_date, :presence => true


  def percentage_of(expenses,expense)
    total = expenses.inject(0) { |total, expense| total += expense.price }
    "%#{(expense.price.to_f/total.to_f).round(2)*100}"
  end

end

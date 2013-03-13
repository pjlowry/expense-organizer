class Expense < ActiveRecord::Base
  has_many :pairings
  has_many :tags, :through => :pairings

  validates :description, :presence => true 
  validates :description, :format => { :with => /^[a-zA-Z0-9 ]+$/ }
  validates :description, :length => { :in => 3..100 }
  before_save :downcase_description

  validates :price, :presence => true
  
  validates :expense_date, :presence => true


  def percentage_of(expenses,expense)
    total = expenses.inject(0) { |total, expense| total += expense.price }
    "%#{(expense.price.to_f/total.to_f).round(2)*100}"
  end

  def category_percentage_of(expenses,expense)
   expense_tag = expense.tags.first
   total_of_tag = expense_tag.expenses.inject(0) { |total, expense| total += expense.price }
   "%#{(expense.price.to_f/total_of_tag.to_f).round(2)*100}"
   #total_of_tag

  end

  private

  def downcase_description
    self.description = self.description.downcase  
  end

end

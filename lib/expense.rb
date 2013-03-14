class Expense < ActiveRecord::Base
  has_many :pairings
  has_many :tags, :through => :pairings

  validates :description,  :presence => true,
                           :format => { :with => /^[a-zA-Z0-9 ]+$/ },
                           :length => { :in => 3..100 }
  validates :price,        :presence => true
  validates :expense_date, :presence => true

  before_save :downcase_description


  def self.percentage_of(expenses,expense)
    total = expenses.inject(0) { |total, expense| total += expense.price }
    "%#{(expense.price.to_f/total.to_f).round(2)*100}"
  end

  def self.category_percentage_of(expenses,expense)
    # expense_tag = expense.tags.first
    

    # if expense_tag 
    #   total_of_tag = expenses.inject(0) do |total, expense| 
    #     if expense_tag
    #       total += expense.price if expense_tag == expense.tags.first
    #     end
    #   end
    #   "%#{(expense.price.to_f/total_of_tag.to_f).round(2)*100}"
    # else
    #   '%UNDEFINED'
    # end
   #total_of_tag
  end

  private

  def downcase_description
    self.description = self.description.downcase  
  end

end

class Expense < ActiveRecord::Base
  has_many :tag

  validates :description, :presence => true 
  validates :description, :format => { :with => /^[a-zA-Z0-9 ]+$/}
  validates :description, :length => { :in => 3..100 }

  validates :price, :presence => true
  
  validates :expense_date, :presence => true



end

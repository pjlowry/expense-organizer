class Tag < ActiveRecord::Base
  belongs_to :expense

  validates :name, :presence => true
  validates :name, :length => { :in => 3..20 }
  validates :name, :format => { :with => /^[a-zA-Z0-9\-\/]+$/}

end
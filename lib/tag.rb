class Tag < ActiveRecord::Base
  has_many :pairings
  has_many :expenses, :through => :pairings

  validates :name, :presence => true
  validates :name, :length => { :in => 3..20 }
  validates :name, :format => { :with => /^[a-zA-Z0-9\-\/]+$/}
  before_save :name_downcase


  private

  def name_downcase
    self.name = self.name.downcase 
  end

end
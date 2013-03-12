class ChangePriceColumn < ActiveRecord::Migration
  def change
    change_column :expenses, :price, :int
  end
end

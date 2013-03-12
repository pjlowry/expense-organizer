class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.column :expense_date, :date
      t.column :price, :float
      t.column :description, :string
      t.column :tag_id, :int

      t.timestamps
    end
  end
end

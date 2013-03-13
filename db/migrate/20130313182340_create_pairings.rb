class CreatePairings < ActiveRecord::Migration
  def change
    create_table :pairings do |t|
      t.column :expense_id, :int
      t.column :tag_id, :int
      t.timestamps
    end
    remove_column :tags, :expense_id
  end
end

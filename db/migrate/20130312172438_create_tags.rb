class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.column :name, :string
      t.column :expense_id, :int
      t.timestamps
    end
    remove_column :expenses, :tag_id
  end
end

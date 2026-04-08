class CreateEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :entries do |t|
      t.integer :moment_id
      t.text :body

      t.timestamps
    end

    add_index :entries, :moment_id
  end
end

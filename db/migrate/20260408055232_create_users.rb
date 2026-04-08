class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :guest_id, null: false

      t.timestamps
    end

    add_index :users, :guest_id, unique: true
  end
end

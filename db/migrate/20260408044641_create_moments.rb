class CreateMoments < ActiveRecord::Migration[8.1]
  def change
    create_table :moments do |t|
      t.integer :user_id
      t.integer :country_id
      t.text :fixed_text
      t.datetime :occurred_at

      t.timestamps
    end

    add_index :moments, :user_id
    add_index :moments, :country_id
  end
end

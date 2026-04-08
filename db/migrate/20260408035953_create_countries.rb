class CreateCountries < ActiveRecord::Migration[8.1]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :country_code
      t.string :timezone

      t.timestamps
    end
  end
end

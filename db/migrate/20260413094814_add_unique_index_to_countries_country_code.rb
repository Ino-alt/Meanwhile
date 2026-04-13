class AddUniqueIndexToCountriesCountryCode < ActiveRecord::Migration[8.1]
  def change
    # country_codeの重複を防ぐユニークインデックスを追加
    add_index :countries, :country_code, unique: true
  end
end

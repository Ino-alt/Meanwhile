class AddNotNullToCountriesCountryCode < ActiveRecord::Migration[8.1]
  def change
    # country_codeにNOT NULL制約を追加する
    change_column_null :countries, :country_code, false
  end
end

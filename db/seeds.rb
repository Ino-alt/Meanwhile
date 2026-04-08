# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

countries = [
  { name: "韓国",       country_code: "KR", timezone: "Asia/Seoul" },
  { name: "トルコ",     country_code: "TR", timezone: "Europe/Istanbul" },
  { name: "ブラジル",   country_code: "BR", timezone: "America/Sao_Paulo" },
  { name: "スウェーデン", country_code: "SE", timezone: "Europe/Stockholm" },
  { name: "オーストラリア", country_code: "AU", timezone: "Australia/Sydney" },
  { name: "ケニア",     country_code: "KE", timezone: "Africa/Nairobi" }
]

countries.each do |attrs|
  Country.find_or_create_by!(country_code: attrs[:country_code]) do |country|
    country.name     = attrs[:name]
    country.timezone = attrs[:timezone]
  end
end

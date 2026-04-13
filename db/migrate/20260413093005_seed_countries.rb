class SeedCountries < ActiveRecord::Migration[8.1]
  def change
    # 表示対象の国データを定義する
    countries = [
      { name: "韓国",           country_code: "KR", timezone: "Asia/Seoul" },
      { name: "トルコ",         country_code: "TR", timezone: "Europe/Istanbul" },
      { name: "ブラジル",       country_code: "BR", timezone: "America/Sao_Paulo" },
      { name: "スウェーデン",   country_code: "SE", timezone: "Europe/Stockholm" },
      { name: "オーストラリア", country_code: "AU", timezone: "Australia/Sydney" },
      { name: "ケニア",         country_code: "KE", timezone: "Africa/Nairobi" }
    ]

    # country_codeで重複チェックしながら登録する（冪等性を保つ）
    countries.each do |attrs|
      Country.find_or_create_by!(country_code: attrs[:country_code]) do |country|
        country.name     = attrs[:name]
        country.timezone = attrs[:timezone]
      end
    end
  end
end

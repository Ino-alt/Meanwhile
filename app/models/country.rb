class Country < ApplicationRecord
  # この国が使われたmoment一覧
  has_many :moments
end

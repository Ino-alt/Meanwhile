class User < ApplicationRecord
  # このユーザーが持つmoment一覧
  has_many :moments
end

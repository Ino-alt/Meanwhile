class Moment < ApplicationRecord
  # このmomentを作成したユーザー
  belongs_to :user

  # このmomentで表示された国
  belongs_to :country

  # このmomentに対して投稿された日記一覧
  has_many :entries
end

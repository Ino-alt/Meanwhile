class Entry < ApplicationRecord
  # どのmomentに対する投稿かを紐づける
  belongs_to :moment

  # 本文が空の投稿を保存しない
  validates :body, presence: true
end

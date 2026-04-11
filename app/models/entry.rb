class Entry < ApplicationRecord
  belongs_to :moment

  validates :body, presence: true
end

class Moment < ApplicationRecord
  belongs_to :user
  belongs_to :country
  has_many :entries
end

class Movie < ApplicationRecord
  validates :title, :year, presence: true

  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  has_many :genres, dependent: :destroy
end

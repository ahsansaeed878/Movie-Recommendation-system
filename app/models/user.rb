class User < ApplicationRecord
  validates :name, :email, presence: true
  validates :email, uniqueness: true

  has_many :likes, dependent: :destroy
  has_many :movies, through: :likes
end

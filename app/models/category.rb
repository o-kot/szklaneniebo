class Category < ApplicationRecord
  has_many :photos
  validates :name, presence: true
end
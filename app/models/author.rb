class Author < ApplicationRecord
  has_one_attached :photo
  validates :about, presence: true
end
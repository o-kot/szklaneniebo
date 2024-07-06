class Category < ApplicationRecord
  has_many :photos, dependent: :nullify
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
class Category < ApplicationRecord
  validates :name, presence: true, length: {maximum: 25, minimum: 3}, uniqueness: true


end
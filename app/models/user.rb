# frozen_string_literal: true

class User < ApplicationRecord
  before_save { self.email = email.downcase } # mutator
  validates :username, presence: true, uniqueness: {case_sensitive: false},
                       length: { minimum: 3, maximum: 15 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true,
                    length: { minimum: 10, maximum: 300 },
                    format: { with: VALID_EMAIL_REGEX }
  # relationships
  has_many(:articles)
  has_secure_password
end

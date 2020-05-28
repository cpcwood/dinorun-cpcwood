# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :scores

  validates :password,
            length: { minimum: 6, too_short: 'The password must have at least 6 characters' }

  validates :username,
            presence: { message: "Username can't be blank" },
            uniqueness: { message: 'Username already taken, please choose another' }

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze, message: 'Email is invalid' }

  validates :email,
            uniqueness: { message: 'Email already taken, please choose another' }
end

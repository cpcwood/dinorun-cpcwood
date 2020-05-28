# frozen_string_literal: true

class Song < ApplicationRecord
  validates :mp3, presence: true
  validates :title, uniqueness: true
  validates :analysed, uniqueness: true
  has_one_attached :mp3
  has_many :scores
end

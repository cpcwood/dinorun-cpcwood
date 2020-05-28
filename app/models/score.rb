# frozen_string_literal: true

class Score < ApplicationRecord
  belongs_to :user
  has_one :song
end

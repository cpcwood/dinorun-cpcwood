# frozen_string_literal: true

class CreateScores < ActiveRecord::Migration[6.0]
  def change
    create_table :scores do |t|
      t.integer :user_id
      t.integer :song_id
      t.integer :score

      t.timestamps
    end
  end
end

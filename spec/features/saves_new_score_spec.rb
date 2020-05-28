# frozen_string_literal: true

require 'rails_helper'
require './spec/features/web_helpers'

feature 'user can upload song', js: true do
  scenario ' user clicks choose file and upload song', driver: :selenium_chrome_headless do
    User.create(username: 'Imraan', email: 'imraan21@hotmail.co.uk', password: 'securepass1')
    log_in
    attach_file('song[mp3]', Rails.root + 'spec/fixtures/test_music.mp3')
    sleep(2)
    click_button 'Create Song'
    find('#song_selection').find(:xpath, 'option[2]').select_option
    click_button 'Play'
    sleep(8)
    expect(Score.all).not_to be_empty
  end
end

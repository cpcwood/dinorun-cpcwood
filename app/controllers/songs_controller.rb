# frozen_string_literal: true

class SongsController < ApplicationController
  skip_before_action :require_login

  # GET /songs.json
  def index
    @songs = Song.all
    render json: @songs
  end

  # GET /songs/1.json
  def show
    @song = Song.find(params[:id])
    render json: { id: @song.id, title: @song.title, bpm: @song.bpm, analysed: @song.analysed, mp3_url: rails_blob_path(@song.mp3_attachment) }
  end

  # POST /songs.json
  def create
    new_song = Song.new(song_params)
    return render json: { status: 200 } if new_song.save

    render json: { status: 500 }
  end

  private

  # Only allow a list of trusted parameters through.
  def song_params
    params.require(:song).permit(:title, :bpm, :analysed, :mp3)
  end
end

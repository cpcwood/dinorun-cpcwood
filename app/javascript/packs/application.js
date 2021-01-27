// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require('jquery')

// Session
import initalizeSession from './session/initalizeSession';

// Game Packs
require("packs/game/background")
require("packs/game/ground")
require("packs/game/block")
require("packs/game/crate")
require("packs/game/dino")
require("packs/game/score")
require("packs/game/renderGame")
require("packs/game/gameController")

// Homepage Interface Packs
require("packs/homepage_interface/songSelector")
require("packs/homepage_interface/userSession")
require("packs/homepage_interface/userInterface")

// mp3 Analysis Packs
require("packs/mp3_analysis/mp3_info")

import GameController from './game/gameController.js'
import SongAnalyser from './mp3_analysis/mp3_info.js'
import { updateSongList, getSong } from './homepage_interface/songSelector.js'
import { toggleLogInForm, toggleSignUpForm, toggleInstructions, touchOrWebInstructions } from './homepage_interface/userInterface.js'
import { generateCanvas } from './homepage_interface/generateCanvas.js'


// Load Page => new game
window.addEventListener('load', function() {
  initalizeSession()
  touchOrWebInstructions()
  generateCanvas()
  var gameController
  var songAnalyser
  var userMessageDiv = document.querySelector('#user-message')
  gameController = new GameController
  gameController.setupGame()
  
  songAnalyser = new SongAnalyser
  songAnalyser.setup()

  updateSongList()

  // Event listner for when form submitted, refactor by changing form to AJAX submit and performing the below in a callback
  // Option to use ActionCable to automatically push new songs to the songList

  document.querySelector('#start_game_btn').addEventListener('click', function() {
    getSong(function(data, audio) {
      userMessageDiv.innerHTML = ''
      $('#user-message').hide()
      gameController.startGame(data, audio)
    })
  })

  document.querySelector('#instruction-button').addEventListener('click', toggleInstructions)

  // Signup and Login
  document.querySelector('#login').addEventListener('click', toggleLogInForm)
  document.querySelector('#signup').addEventListener('click', toggleSignUpForm)

  document.body.addEventListener("ajax:success", function(event) {
    $('#user-message').text('The Song is successfully analysed. Enjoy the game').show()
    updateSongList()
    document.querySelector("#song_mp3").value = ""
  })

  document.body.addEventListener("ajax:error", function(event) {  
    $('#user-message').text('Song exists mate. Pick the song from the list above').show()
  })

  $('#create_song_btn').click( () => $('#create_song_btn').hide("slide") )
})
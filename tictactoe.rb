#!/usr/bin/env ruby

require_relative 'lib/game'
require_relative 'lib/game_io'


game = Game.new GameIO.new
game.show_menu

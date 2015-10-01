#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require_relative 'test_helper'
require_relative '../lib/player'
require_relative '../lib/game_engine'

class GameEngineTest < Minitest::Test
  
  def test_change_player_first_player
    player1 = Player.new :human, 'X'
    player2 = Player.new :human, 'O'
    mock = Minitest::Mock.new
    engine = GameEngine.new(player1, player2, mock)
    result_player = engine.change_player true
    assert_same player1, result_player
  end

  def test_change_player_not_first_player
    player1 = Player.new :human, 'X'
    player2 = Player.new :human, 'O'
    mock = Minitest::Mock.new
    engine = GameEngine.new(player1, player2, mock)
    result_player  = engine.change_player false
    assert_same player2, result_player
  end
end

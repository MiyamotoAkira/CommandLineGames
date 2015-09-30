#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require_relative 'test_helper'
require_relative '../lib/game_engine'

class GameEngineTest < Minitest::Test
  def setup
    @marks = {player1_mark: 'O', player2_mark: 'X'}
  end
  
  def test_change_player_first_player
    player1 = Object.new
    player2 = Object.new
    mock = Minitest::Mock.new
    engine = GameEngine.new(player1, player2, @marks, mock)
    result_player, result_player_mark = engine.change_player true
    assert_same player1, result_player
    assert_equal @marks[:player1_mark], result_player_mark
  end

  def test_change_player_not_first_player
    player1 = Object.new
    player2 = Object.new
    mock = Minitest::Mock.new
    engine = GameEngine.new(player1, player2, @marks, mock)
    result_player, result_player_mark = engine.change_player false
    assert_same player2, result_player
    assert_equal @marks[:player2_mark], result_player_mark
  end
end

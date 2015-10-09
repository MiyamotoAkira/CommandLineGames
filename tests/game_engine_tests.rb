#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require_relative 'test_helper'
require_relative '../lib/player'
require_relative '../lib/game_engine'

class GameEngineTest < Minitest::Test
  def setup
    @player1 = Player.new :human, 'X'
    @player2 = Player.new :human, 'O'    
  end
  
  def test_change_player_first_player
    board = Minitest::Mock.new
    engine = GameEngine.new(@player1, @player2, board)
    result_player = engine.change_player true
    assert_same @player1, result_player
  end

  def test_change_player_not_first_player
    board = Minitest::Mock.new
    engine = GameEngine.new(@player1, @player2, board)
    result_player  = engine.change_player false
    assert_same @player2, result_player
  end

  def test_get_player_spot_when_get_move_is_nil_it_keeps_trying
    board = Minitest::Mock.new
    board.expect(:==, true, [Minitest::Mock])
    player = Minitest::Mock.new
    player.expect(:mark, 'X')
    player.expect(:mark, 'X')
    player.expect(:get_move, nil, [Board, String, String])
    player.expect(:get_move, 4, [Board, String, String])
    engine = GameEngine.new(@player1, @player2, board)
    assert_equal 4, engine.get_player_spot(player)
  end
end

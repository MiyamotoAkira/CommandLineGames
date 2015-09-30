#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require_relative 'test_helper'
require_relative '../lib/game_engine'

class GameEngineTest < Minitest::Test
  def setup
    @marks = {player1_mark: 'O', player2_mark: 'X'}
  end
  
  def test_check_board_availability_available_spot_is_true
    mock = Minitest::Mock.new
    engine = GameEngine.new(mock, mock, @marks, mock)
    assert_equal true, engine.check_board_spot_availability(0)
  end
end

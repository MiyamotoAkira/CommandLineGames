#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require_relative 'test_helper'
require_relative '../lib/game_engine'
require_relative '../lib/computer_strategy_hard'

class GameEngineTest < Minitest::Test
  def test_get_move_first_move_no_center_chosen_center
    board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    computer = ComputerStrategyHard.new
    assert_equal 4, computer.get_move(board, 'O', 'O', 'X') { |board| false}
  end
end

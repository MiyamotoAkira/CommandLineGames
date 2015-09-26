#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require_relative 'test_helper'
require_relative '../lib/game_engine'
require_relative '../lib/computer_strategy_hard'

class GameEngineTest < Minitest::Test
  def setup
    @corners = [0,2,6,8]
  end
  
  def test_get_move_first_move_no_center_chosen_center
    test_board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    computer = ComputerStrategyHard.new
    assert_includes @corners, computer.get_move(test_board, 'O', 'O', 'X') { |board| false}
  end

  def test_get_move_second_move_no_center_chosen_center
    test_board = ["0", "1", "O", "3", "4", "5", "6", "7", "8"]
    computer = ComputerStrategyHard.new
    assert_equal 4, (computer.get_move(test_board, 'O', 'O', 'X') { |board| false})
  end
  
  def test_get_move_second_move_center_is_occupied_use_corner
    test_board = ["0", "1", "2", "3", "X", "5", "6", "7", "8"]
    computer = ComputerStrategyHard.new
    assert_includes @corners, (computer.get_move(test_board, 'O', 'O', 'X') { |board| false})
  end
end

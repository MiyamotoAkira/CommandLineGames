#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require_relative 'test_helper'
require_relative '../lib/game_engine'
require_relative '../lib/computer_strategy_hard'

class ComputerStrategyHardTest < Minitest::Test
  def setup
    @corners = [0,2,6,8]
  end
  
  def test_check_treatening_found_board_left_as_started
    test_board = ["O", "1", "2", "3", "X", "5", "6", "7", "8"]
    computer = ComputerStrategyHard.new
    engine = GameEngine.new computer
    computer.get_move(test_board, 'O', 'X') {|board| engine.game_is_over(board)}
    assert_equal 7, (computer.get_available_spaces(test_board, 'O', 'X')).length  
  end

  def test_get_move_first_move_no_center_chosen_center
    test_board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    computer = ComputerStrategyHard.new
    assert_includes @corners, computer.get_move(test_board, 'O', 'X') { |board| false}
  end

  def test_get_move_second_move_no_center_chosen_center
    test_board = ["0", "1", "X", "3", "4", "5", "6", "7", "8"]
    computer = ComputerStrategyHard.new
    assert_equal 4, computer.get_move(test_board, 'O', 'X') { |board| false}
  end
  
  def test_get_move_second_move_center_is_occupied_use_corner
    test_board = ["0", "1", "2", "3", "X", "5", "6", "7", "8"]
    computer = ComputerStrategyHard.new
    assert_includes @corners, computer.get_move(test_board, 'O', 'X') { |board| false}
  end

  def test_get_move_player_is_ready_to_score_blocks
    test_board = ["X", "1", "O", "3", "X", "5", "6", "7", "8"]
    computer = ComputerStrategyHard.new
    engine = GameEngine.new computer
    assert_equal 8, computer.get_move(test_board, 'O', 'X') {|board| engine.game_is_over(board)}
  end

  def test_get_move_computer_is_ready_to_score_score
    test_board = ["X", "X", "O", "3", "X", "5", "6", "7", "O"]
    computer = ComputerStrategyHard.new
    engine = GameEngine.new computer
    assert_equal 5, computer.get_move(test_board, 'O', 'X') {|board| engine.game_is_over(board)}
  end

  def test_get_move_player_no_threatening_fork_available_use_fork
    test_board = ["O", "X", "O", "3", "4", "X", "6", "7", "X"]
    computer = ComputerStrategyHard.new
    engine = GameEngine.new computer
    assert_equal 6, computer.get_move(test_board, 'O', 'X') {|board| engine.game_is_over(board)}
  end

  def test_get_move_player_no_threatening_no_fork_available_use_threatening
    test_board = ["O", "1", "2", "3", "X", "5", "6", "7", "8"]
    computer = ComputerStrategyHard.new
    engine = GameEngine.new computer
    assert_equal 1, computer.get_move(test_board, 'O', 'X') {|board| engine.game_is_over(board)}
  end

end

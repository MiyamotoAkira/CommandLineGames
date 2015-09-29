#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require_relative 'test_helper'
require_relative '../lib/game_engine'
require_relative '../lib/computer_strategy_easy'

class ComputerStrategyEasyTest < Minitest::Test

  def setup
    @marks = {player1_mark: 'O', player2_mark: 'X'}
  end
       
  def test_check_treatening_found_board_left_as_started
    test_board = ["O", "1", "2", "3", "X", "5", "6", "7", "8"]
    computer = ComputerStrategyEasy.new
    mock = Minitest::Mock.new
    engine = GameEngine.new(computer, mock, @marks)
    computer.get_move(test_board, 'O', 'X') {|board| engine.game_is_over(board)}
    assert_equal 7, (computer.get_available_spaces(test_board, 'O', 'X')).length    
  end
  
  def test_get_move_first_move_no_center_random_chosen
    test_board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    computer = ComputerStrategyEasy.new
    assert_includes [0,1,2,3,4,5,6,7,8], computer.get_move(test_board, 'O', 'X') { |board| false}
  end

  def test_get_move_second_move_no_center_random_chosen
    test_board = ["0", "1", "X", "3", "4", "5", "6", "7", "8"]
    computer = ComputerStrategyEasy.new
    assert_includes [0,1,3,4,5,6,7,8], computer.get_move(test_board, 'O', 'X') { |board| false}
  end

  def test_get_move_second_move_center_used_random_chosen
    test_board = ["0", "1", "2", "3", "X", "5", "6", "7", "8"]
    computer = ComputerStrategyEasy.new
    assert_includes [0,1,2,3,5,6,7,8], computer.get_move(test_board, 'O', 'X') { |board| false}
  end

  def test_get_move_player_is_ready_to_score_random_chosen
    test_board = ["X", "1", "O", "3", "X", "5", "6", "7", "8"]
    computer = ComputerStrategyEasy.new
    mock = Minitest::Mock.new
    engine = GameEngine.new(computer, mock, @marks)
    assert_includes [1,3,5,6,7,8], computer.get_move(test_board, 'O', 'X') {|board| engine.game_is_over(board)}
  end

  def test_get_move_computer_is_ready_to_score_score
    test_board = ["X", "X", "O", "3", "X", "5", "6", "7", "O"]
    computer = ComputerStrategyMedium.new
    mock = Minitest::Mock.new
    engine = GameEngine.new(computer, mock, @marks)
    assert_equal 5, computer.get_move(test_board, 'O', 'X') {|board| engine.game_is_over(board)}
  end

  def test_get_move_player_no_threatening_no_fork_available_use_threatening
    test_board = ["O", "1", "2", "3", "X", "5", "6", "7", "8"]
    computer = ComputerStrategyMedium.new
    mock = Minitest::Mock.new
    engine = GameEngine.new(computer, mock, @marks)
    assert_includes [0,1,2,3,5,6,7,8], computer.get_move(test_board, 'O', 'X') {|board| engine.game_is_over(board)}
  end
end

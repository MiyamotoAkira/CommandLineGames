#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require_relative 'test_helper'
require_relative '../lib/board'
require_relative '../lib/computer_strategy_medium'

class ComputerStrategyMediumTest < Minitest::Test
  def setup
    @corners = [0,2,6,8]
    @marks = {player1_mark: 'O', player2_mark: 'X'}
  end
  
  def test_check_treatening_found_board_left_as_started
    test_board = Board.new @marks[:player1_mark], @marks[:player2_mark]
    test_board.occupy_spot 0, @marks[:player1_mark]
    test_board.occupy_spot 4, @marks[:player2_mark]
    computer = ComputerStrategyMedium.new
    computer.get_move(test_board, @marks[:player1_mark], @marks[:player2_mark])
    assert_equal 7, test_board.get_available_spaces.length  
  end

  def test_get_move_first_move_no_center_chosen_center
    test_board = Board.new @marks[:player1_mark], @marks[:player2_mark]
    computer = ComputerStrategyMedium.new
    assert_equal 4, computer.get_move(test_board, @marks[:player1_mark], @marks[:player2_mark])
  end

  def test_get_move_second_move_no_center_chosen_center
    test_board = Board.new @marks[:player1_mark], @marks[:player2_mark]
    test_board.occupy_spot 2, @marks[:player2_mark]
    computer = ComputerStrategyMedium.new
    assert_equal 4, computer.get_move(test_board, @marks[:player1_mark], @marks[:player2_mark])
  end

  def test_get_move_second_move_center_used_random_chosen
    test_board = Board.new @marks[:player1_mark], @marks[:player2_mark]
    test_board.occupy_spot 4, @marks[:player2_mark]
    computer = ComputerStrategyMedium.new
    assert_includes [0,1,2,3,5,6,7,8], computer.get_move(test_board, @marks[:player1_mark], @marks[:player2_mark])
  end

  def test_get_move_player_is_ready_to_score_blocks
    test_board = Board.new @marks[:player1_mark], @marks[:player2_mark]
    test_board.occupy_spot 0, @marks[:player2_mark]
    test_board.occupy_spot 2, @marks[:player1_mark]
    test_board.occupy_spot 4, @marks[:player2_mark]
    computer = ComputerStrategyMedium.new
    assert_equal 8, computer.get_move(test_board, @marks[:player1_mark], @marks[:player2_mark])
  end

  def test_get_move_computer_is_ready_to_score_score
    test_board = Board.new @marks[:player1_mark], @marks[:player2_mark]
    test_board.occupy_spot 0, @marks[:player2_mark]
    test_board.occupy_spot 1, @marks[:player2_mark]
    test_board.occupy_spot 2, @marks[:player1_mark]
    test_board.occupy_spot 4, @marks[:player2_mark]
    test_board.occupy_spot 8, @marks[:player1_mark]
    computer = ComputerStrategyMedium.new
    assert_equal 5, computer.get_move(test_board, @marks[:player1_mark], @marks[:player2_mark])
  end

  def test_get_move_player_no_threatening_no_fork_available_use_threatening
    test_board = Board.new @marks[:player1_mark], @marks[:player2_mark]
    test_board.occupy_spot 0, @marks[:player2_mark]
    test_board.occupy_spot 4, @marks[:player1_mark]
    computer = ComputerStrategyMedium.new
    assert_includes [0,1,2,3,5,6,7,8], computer.get_move(test_board, @marks[:player1_mark], @marks[:player2_mark])
  end

end

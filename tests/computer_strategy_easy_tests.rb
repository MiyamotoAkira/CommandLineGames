#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require_relative 'test_helper'
require_relative '../lib/board'
require_relative '../lib/computer_strategy_easy'

class ComputerStrategyEasyTest < Minitest::Test

  def setup
    @marks = {player1_mark: 'O', player2_mark: 'X'}
  end
       
  def test_check_treatening_found_board_left_as_started
    test_board = Board.new @marks[:player1_mark], @marks[:player2_mark]
    test_board.occupy_spot 0, @marks[:player1_mark]
    test_board.occupy_spot 4, @marks[:player2_mark]
    computer = ComputerStrategyEasy.new
    computer.get_move(test_board, @marks[:player1_mark], @marks[:player2_mark])
    assert_equal 7, test_board.get_available_spaces.length
  end
  
  def test_get_move_first_move_no_center_random_chosen
    test_board = Board.new @marks[:player1_mark], @marks[:player2_mark]
    computer = ComputerStrategyEasy.new
    assert_includes [0,1,2,3,4,5,6,7,8], computer.get_move(test_board, @marks[:player1_mark], @marks[:player2_mark])
  end

  def test_get_move_second_move_no_center_random_chosen
    test_board = Board.new @marks[:player1_mark], @marks[:player2_mark]
    test_board.occupy_spot 2, @marks[:player2_mark]
    computer = ComputerStrategyEasy.new
    assert_includes [0,1,3,4,5,6,7,8], computer.get_move(test_board, @marks[:player1_mark], @marks[:player2_mark])
  end

  def test_get_move_second_move_center_used_random_chosen
    test_board = Board.new @marks[:player1_mark], @marks[:player2_mark]
    test_board.occupy_spot 4, @marks[:player1_mark]
    computer = ComputerStrategyEasy.new
    assert_includes [0,1,2,3,5,6,7,8], computer.get_move(test_board, @marks[:player1_mark], @marks[:player2_mark])
  end

  def test_get_move_player_is_ready_to_score_random_chosen
    test_board = Board.new @marks[:player1_mark], @marks[:player2_mark]
    test_board.occupy_spot 0, @marks[:player2_mark]
    test_board.occupy_spot 2, @marks[:player1_mark]
    test_board.occupy_spot 4, @marks[:player2_mark]
    computer = ComputerStrategyEasy.new
    assert_includes [1,3,5,6,7,8], computer.get_move(test_board, @marks[:player1_mark], @marks[:player2_mark])
  end

  def test_get_move_computer_is_ready_to_score_score
    test_board = Board.new @marks[:player1_mark], @marks[:player2_mark]
    test_board.occupy_spot 0, @marks[:player2_mark]
    test_board.occupy_spot 1, @marks[:player2_mark]
    test_board.occupy_spot 2, @marks[:player1_mark]
    test_board.occupy_spot 4, @marks[:player1_mark]
    test_board.occupy_spot 8, @marks[:player2_mark]
    computer = ComputerStrategyMedium.new
    assert_equal 6, computer.get_move(test_board, @marks[:player1_mark], @marks[:player2_mark])
  end
end

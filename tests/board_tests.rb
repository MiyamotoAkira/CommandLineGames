#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require_relative 'test_helper'
require_relative '../lib/board'

class BoardTest < MiniTest::Test

  def setup
    @player1_mark = 'X'
    @player2_mark = 'O'
  end

  [0,1,2,3,4,5,6,7,8].each do |cell|
    define_method("test_check_board_spot_availability_on_empty_board_is_true_#{cell}") do
      board = Board.new @player1_mark, @player2_mark
      assert_equal true, board.check_board_spot_availability(cell)
    end
  end

  
  [0,1,2,3,4,5,6,7,8].each do |cell|
    define_method("test_occupy_spot_#{cell}") do
      board = Board.new @player1_mark, @player2_mark
      assert_equal true, board.check_board_spot_availability(cell)
      board.occupy_spot cell, @player1_mark
      assert_equal false, board.check_board_spot_availability(cell)
    end
  end

  def test_at_leat_one_line_the_same_starting_state_returns_false
    board = Board.new @player1_mark, @player2_mark
    assert_equal false, board.at_least_one_line_the_same
  end

  def test_at_leat_one_line_the_same_line_is_different_elements_returns_false
    board = Board.new @player1_mark, @player2_mark
    board.occupy_spot 0, @player1_mark
    board.occupy_spot 1, @player2_mark
    board.occupy_spot 2, @player1_mark
    assert_equal false, board.at_least_one_line_the_same
  end

  def test_at_leat_one_line_the_same_line_is_the_same_returns_true
    board = Board.new @player1_mark, @player2_mark
    board.occupy_spot 0, @player1_mark
    board.occupy_spot 1, @player1_mark
    board.occupy_spot 2, @player1_mark    
    assert_equal true, board.at_least_one_line_the_same
  end
end

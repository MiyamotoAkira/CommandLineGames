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

  def test_get_available_spaces_new_board
    board = Board.new @player1_mark, @player2_mark
    assert_equal 9, board.get_available_spaces.length
  end

  def test_get_available_spaces_some_occupied
    board = Board.new @player1_mark, @player2_mark
    board.occupy_spot 0, @player2_mark
    board.occupy_spot 2, @player1_mark
    board.occupy_spot 4, @player2_mark
    assert_equal ["1","3","5","6","7","8"], board.get_available_spaces
  end

  def test_check_upper_left_corner_should_be_empty
    board = Board.new @player1_mark, @player2_mark
    assert_equal :empty, board.check_upper_left_corner
  end

  def test_check_upper_right_corner_should_be_empty
    board = Board.new @player1_mark, @player2_mark
    assert_equal :empty, board.check_upper_right_corner
  end

  def test_check_lower_left_corner_should_be_empty
    board = Board.new @player1_mark, @player2_mark
    assert_equal :empty, board.check_lower_left_corner
  end

  def test_check_lower_right_corner_should_be_empty
    board = Board.new @player1_mark, @player2_mark
    assert_equal :empty, board.check_lower_right_corner
  end

  def test_setup_board_size_3
    size = 3
    board = Board.new @player1_mark, @player2_mark, size
    assert_equal 9, board.board_positions.length
    assert_equal 0, board.upper_left_corner
    assert_equal 2, board.upper_right_corner
    assert_equal 6, board.lower_left_corner
    assert_equal 8, board.lower_right_corner
  end

  def test_setup_board_size_4
    size = 4
    board = Board.new @player1_mark, @player2_mark, size
    assert_equal 16, board.board_positions.length
    assert_equal 0, board.upper_left_corner
    assert_equal 3, board.upper_right_corner
    assert_equal 12, board.lower_left_corner
    assert_equal 15, board.lower_right_corner
  end

  def test_check_unique_horizontal_no_equals
    board = Board.new @player1_mark, @player2_mark
    assert_equal false, board.check_unique_horizontal
  end

  def test_check_unique_horizontal_first_horizontal
    board = Board.new @player1_mark, @player2_mark
    board.occupy_spot 0, 'X'
    board.occupy_spot 1, 'X'
    board.occupy_spot 2, 'X'
    assert_equal true, board.check_unique_horizontal
  end

  def test_check_unique_horizontal_second_horizontal
    board = Board.new @player1_mark, @player2_mark
    board.occupy_spot 3, 'X'
    board.occupy_spot 4, 'X'
    board.occupy_spot 5, 'X'
    assert_equal true, board.check_unique_horizontal
  end  

  def test_check_unique_horizontal_size_4_second_horizontal
    board = Board.new @player1_mark, @player2_mark, 4
    board.occupy_spot 4, 'X'
    board.occupy_spot 5, 'X'
    board.occupy_spot 6, 'X'
    board.occupy_spot 7, 'X'
    assert_equal true, board.check_unique_horizontal
  end

  def test_check_unique_vertical_no_equals
    board = Board.new @player1_mark, @player2_mark
    assert_equal false, board.check_unique_vertical
  end

  def test_check_unique_vertical_first_vertical
    board = Board.new @player1_mark, @player2_mark
    board.occupy_spot 0, 'X'
    board.occupy_spot 3, 'X'
    board.occupy_spot 6, 'X'
    assert_equal true, board.check_unique_vertical
  end

  def test_check_unique_vertical_second_vertical
    board = Board.new @player1_mark, @player2_mark
    board.occupy_spot 1, 'X'
    board.occupy_spot 4, 'X'
    board.occupy_spot 7, 'X'
    assert_equal true, board.check_unique_vertical
  end  

  def test_check_unique_vertical_size_4_second_vertical
    board = Board.new @player1_mark, @player2_mark, 4
    board.occupy_spot 1, 'X'
    board.occupy_spot 5, 'X'
    board.occupy_spot 9, 'X'
    board.occupy_spot 13, 'X'
    assert_equal true, board.check_unique_vertical
  end

  def test_check_unique_diagonal_no_equals
    board = Board.new @player1_mark, @player2_mark
    assert_equal false, board.check_unique_diagonal
  end

  def test_check_unique_diagonal_first_diagonal
    board = Board.new @player1_mark, @player2_mark
    board.occupy_spot 0, 'X'
    board.occupy_spot 4, 'X'
    board.occupy_spot 8, 'X'
    assert_equal true, board.check_unique_diagonal
  end

  def test_check_unique_diagonal_second_diagonal
    board = Board.new @player1_mark, @player2_mark
    board.occupy_spot 2, 'X'
    board.occupy_spot 4, 'X'
    board.occupy_spot 6, 'X'
    assert_equal true, board.check_unique_diagonal
  end  

  def test_check_unique_diagonal_size_4_second_diagonal
    board = Board.new @player1_mark, @player2_mark, 4
    board.occupy_spot 3, 'X'
    board.occupy_spot 6, 'X'
    board.occupy_spot 9, 'X'
    board.occupy_spot 12, 'X'
    assert_equal true, board.check_unique_diagonal
  end
  
end

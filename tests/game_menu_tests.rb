#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require_relative 'test_helper'
require_relative '../lib/game_engine'
require_relative '../lib/game_menu'

class GameMenuTest < Minitest::Test
  
  def test_get_option_main_1_is_start
    mockedIO = Minitest::Mock.new
    mockedIO.expect(:get_input_as_int, 1)
    menu = GameMenu.new mockedIO
    assert_equal :start, menu.get_option_main
  end

  def test_get_option_main_2_is_difficulty
    mockedIO = Minitest::Mock.new
    mockedIO.expect(:get_input_as_int, 2)
    menu = GameMenu.new mockedIO
    assert_equal :difficulty, menu.get_option_main
  end
  
  def test_get_option_main_9_is_exit
    mockedIO = Minitest::Mock.new
    mockedIO.expect(:get_input_as_int, 9)
    menu = GameMenu.new mockedIO
    assert_equal :exit, menu.get_option_main
  end
  
  def test_get_option_difficulty_1_is_hard
    mockedIO = Minitest::Mock.new
    mockedIO.expect(:get_input_as_int, 1)
    menu = GameMenu.new mockedIO
    assert_equal :hard, menu.get_option_difficulty
  end
  
  def test_get_option_difficulty_2_is_medium
    mockedIO = Minitest::Mock.new
    mockedIO.expect(:get_input_as_int, 2)
    menu = GameMenu.new mockedIO
    assert_equal :medium, menu.get_option_difficulty
  end
  
  def test_get_option_difficulty_3_is_easy
    mockedIO = Minitest::Mock.new
    mockedIO.expect(:get_input_as_int, 3)
    menu = GameMenu.new mockedIO
    assert_equal :easy, menu.get_option_difficulty
  end
end

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

  def test_get_option_main_2_is_player1
    mockedIO = Minitest::Mock.new
    mockedIO.expect(:get_input_as_int, 2)
    menu = GameMenu.new mockedIO
    assert_equal :player1, menu.get_option_main
  end
  
  def test_get_option_main_3_is_player2
    mockedIO = Minitest::Mock.new
    mockedIO.expect(:get_input_as_int, 3)
    menu = GameMenu.new mockedIO
    assert_equal :player2, menu.get_option_main
  end

  def test_get_option_main_9_is_exit
    mockedIO = Minitest::Mock.new
    mockedIO.expect(:get_input_as_int, 9)
    menu = GameMenu.new mockedIO
    assert_equal :exit, menu.get_option_main
  end

  def test_get_option_players_1_is_human
    mockedIO = Minitest::Mock.new
    mockedIO.expect(:get_input_as_int, 1)
    menu = GameMenu.new mockedIO
    assert_equal :human, menu.get_option_players
  end

  def test_get_option_players_2_is_easy
    mockedIO = Minitest::Mock.new
    mockedIO.expect(:get_input_as_int, 2)
    menu = GameMenu.new mockedIO
    assert_equal :easy, menu.get_option_players
  end
  
  def test_get_option_players_3_is_medium
    mockedIO = Minitest::Mock.new
    mockedIO.expect(:get_input_as_int, 3)
    menu = GameMenu.new mockedIO
    assert_equal :medium, menu.get_option_players
  end

  def test_get_option_players_4_is_hard
    mockedIO = Minitest::Mock.new
    mockedIO.expect(:get_input_as_int, 4)
    menu = GameMenu.new mockedIO
    assert_equal :hard, menu.get_option_players
  end
end

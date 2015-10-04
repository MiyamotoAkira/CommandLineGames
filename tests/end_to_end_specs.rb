#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require_relative 'test_helper'
require_relative '../lib/game'
#require_relative 'minitest/spec'

class IoMock
  def initialize
    @calls = []
    @last_messages = nil
    @called = []
  end

  def welcome
  end

  def output_board b
  end

  def select_spot_info
  end
  
  def clear_screen
  end

  def show_selections a, b
  end

  def end_of_game
    @called << :end_of_game
  end

  def get_input
    @calls.shift
  end

  def get_input_as_int
    @calls.shift
  end

  def output_messages messages
    @last_messages = messages
  end

  def add_to_queue input
    @calls.push input
  end

  def check_called method
    @called.include? method
  end

  def check_message_is_present expected
    @last_messages.each do |message|
      return true if message.include? expected
    end
    return false
  end
end

describe "I select to change Player 1 to Hard" do
  mock = IoMock.new
  mock.add_to_queue 2
  mock.add_to_queue 1
  mock.add_to_queue 4
  #This last call is to exit the class. Otherwise gets stuck
  mock.add_to_queue 9 
  it "Shows on the screen Player1 is Computer Hard" do
    game = Game.new mock
    game.show_menu
    mock.check_message_is_present("Computer Hard").must_equal true
  end
end

describe "I select to change Player 1 to Easy" do
  mock = IoMock.new
  mock.add_to_queue 2
  mock.add_to_queue 1
  mock.add_to_queue 2
  #This last call is to exit the class. Otherwise gets stuck
  mock.add_to_queue 9
  it "Shows on the screen Player1 is Computer Easy" do
    game = Game.new mock
    game.show_menu
    mock.check_message_is_present("Computer Easy").must_equal true
  end
end

describe "Two Human Players play" do
  mock = IoMock.new
  mock.add_to_queue 1
  mock.add_to_queue "0"
  mock.add_to_queue "4"
  mock.add_to_queue "1"
  mock.add_to_queue "3"
  mock.add_to_queue "2"
  mock.add_to_queue 9

  it "Shows Game Over" do
    game = Game.new mock
    game.show_menu
    mock.check_called(:end_of_game).must_equal true
  end
end

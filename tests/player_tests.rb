#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require_relative 'test_helper'
require_relative '../lib/player'

class PlayerTest < Minitest::Test
  def test_get_move_underlying_is_called
    mock = Minitest::Mock.new
    mock.expect(:get_move, true, [Object, String, String])
    player = Player.new mock, 'X'
    assert_equal true, player.get_move(Object.new, 'X', 'O')
  end
end


#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require_relative 'test_helper'
require_relative '../lib/game_engine'

class GameEngineTest < Minitest::Test
  def test_validate_input_no_valid_is_false
    engine = GameEngine.new
    assert_equal false, engine.validate_input('d')
  end

  def test_validate_input_more_than_one_character_is_false
    engine = GameEngine.new
    assert_equal false, engine.validate_input('09')
  end

  def test_validate_input_valid_number_is_true
    engine = GameEngine.new
    assert_equal true, engine.validate_input('9')
  end
end

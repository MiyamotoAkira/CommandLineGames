#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require_relative '../test_helper'
require_relative '../../lib/strategy/human'

class HumanTest < Minitest::Test
  def test_validate_input_no_valid_is_false
    mock = Minitest::Mock.new
    player = Strategy::Human.new mock
    assert_equal false, player.validate_input('d')
  end

  def test_validate_input_more_than_one_character_is_false
    mock = Minitest::Mock.new
    player = Strategy::Human.new mock
    assert_equal false, player.validate_input('09')
  end

  def test_validate_input_valid_number_is_true
    mock = Minitest::Mock.new
    player = Strategy::Human.new mock
    assert_equal true, player.validate_input('9')
  end
end

#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require_relative '../test_helper'
require_relative '../../lib/strategy/computer_base'

class ComputerBaseTest < Minitest::Test
  def test_check_possible_score_none_available_should_return_nil
    mock = Minitest::Mock.new
    mock.expect(:get_available_spaces, ["1","3","5","6","7","8"])
    ["1","3","5","6","7","8"].each {||mock.expect(:occupy_spot, nil, [Integer, String])}
    ["1","3","5","6","7","8"].each {||mock.expect(:occupy_spot, nil, [Integer, String])}
    ["1","3","5","6","7","8"].each {||mock.expect(:at_least_one_line_the_same, false)}
    computer = Object.new
    computer.extend(Strategy::ComputerBase)
    assert_equal nil, computer.check_possible_score(mock, 'X')
  end
end

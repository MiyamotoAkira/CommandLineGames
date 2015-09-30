class Board
  attr_reader :board_positions
  
  def initialize player1_mark, player2_mark
    @board_positions = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @player1_mark = player1_mark
    @player2_mark = player2_mark
  end

  def check_board_spot_availability(spot)
    @board_positions[spot] != @player1_mark && @board_positions[spot] != @player2_mark
  end

  def occupy_spot spot, mark
    @board_positions[spot] = mark
  end

  def at_least_one_line_the_same
    [@board_positions[0], @board_positions[1], @board_positions[2]].uniq.length == 1 ||
    [@board_positions[3], @board_positions[4], @board_positions[5]].uniq.length == 1 ||
    [@board_positions[6], @board_positions[7], @board_positions[8]].uniq.length == 1 ||
    [@board_positions[0], @board_positions[3], @board_positions[6]].uniq.length == 1 ||
    [@board_positions[1], @board_positions[4], @board_positions[7]].uniq.length == 1 ||
    [@board_positions[2], @board_positions[5], @board_positions[8]].uniq.length == 1 ||
    [@board_positions[0], @board_positions[4], @board_positions[8]].uniq.length == 1 ||
    [@board_positions[2], @board_positions[4], @board_positions[6]].uniq.length == 1
  end

  def tie
    @board_positions.all? { |s| s == @player1_mark || s == @player2_mark }
  end

  def get_available_spaces
    available_spaces = []
    @board_positions.each do |s|
      if s != @player1_mark && s != @player2_mark
        available_spaces << s
      end
    end
    available_spaces
  end
end

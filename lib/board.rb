class Board
  attr_reader :board_positions, :upper_left_corner, :upper_right_corner, :lower_left_corner, :lower_right_corner
  
  def initialize player1_mark, player2_mark, size = 3
    @size = size
    @upper_left_corner = 0
    @upper_right_corner = 2
    @lower_left_corner = 6
    @lower_right_corner = 8
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


  def check_corner(corner)
    return :empty if @board_positions[corner] != @player1_mark && @board_positions[corner] != @player2_mark
    return :occupied
  end
  
  def check_upper_left_corner
    check_corner @upper_left_corner
  end
  
  def check_upper_right_corner
    check_corner @upper_right_corner
  end
  
  def check_lower_left_corner
    check_corner @lower_left_corner
  end
  
  def check_lower_right_corner
    check_corner @lower_right_corner
  end
end

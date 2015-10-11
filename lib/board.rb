class Board
  attr_reader :board_positions, :upper_left_corner, :upper_right_corner, :lower_left_corner, :lower_right_corner
  
  def initialize player1_mark, player2_mark, size = 3
    @size = size
    setup_board
    @player1_mark = player1_mark
    @player2_mark = player2_mark
  end

  def setup_board
    @board_positions = []
    (0...(@size*@size)).each do |position|
      @board_positions << position.to_s
    end

    @upper_left_corner = 0
    @upper_right_corner = @size - 1
    @lower_left_corner = (@size * @size) - @size
    @lower_right_corner = (@size * @size) - 1
  end

  def check_board_spot_availability(spot)
    @board_positions[spot] != @player1_mark && @board_positions[spot] != @player2_mark
  end

  def occupy_spot spot, mark
    @board_positions[spot] = mark
  end

  def at_least_one_line_the_same
    check_unique_horizontal || check_unique_vertical || check_unique_diagonal
  end

  def check_unique_horizontal
    (0...@size).each do |line|
      positions = get_positions_for_line line
      all_equal = check_for_uniqueness_on_positions positions
      return all_equal if all_equal
    end
    false
  end

  def check_for_uniqueness_on_positions positions
    all_equal = true
    positions.each_with_index do |position, index|
      if index != 0
        all_equal = all_equal && (@board_positions[position] == @board_positions[positions[index - 1]])
      end
    end
    all_equal
  end
  
  def check_unique_vertical
    (0...@size).each do |column|
      positions = get_positions_for_column column
      all_equal = check_for_uniqueness_on_positions positions
      return all_equal if all_equal
    end
    false
  end

  def get_positions_for_line line
    positions = []
    (0...@size).each do |column|
      positions << (line * @size) + column
    end
    positions
  end
  
  def get_positions_for_column column
    positions = []
    (0...@size).each do |line|
      positions << (line * @size) + column
    end
    positions
  end

  def get_positions_for_diagonal
    positions = []
    (0...@size).each_with_index do |line, index|
      positions << (line * @size) + yield(index)
    end
    positions
  end
  
  def check_unique_diagonal
    positions = get_positions_for_diagonal {|index| index}
    all_equal = check_for_uniqueness_on_positions positions
    return all_equal if all_equal
    positions = get_positions_for_diagonal {|index| (@size - index - 1) }
    check_for_uniqueness_on_positions positions
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

class Board
  attr_reader :board_positions, :upper_left_corner, :upper_right_corner, :lower_left_corner, :lower_right_corner
  
  def initialize player1_mark, player2_mark, size = 3
    @size = size
    setup_board
    setup_corners
    @player1_mark = player1_mark
    @player2_mark = player2_mark
  end

  def setup_board
    @board_positions = []
    (0...(@size*@size)).each do |position|
      @board_positions << position.to_s
    end
  end

  def setup_corners
    @upper_left_corner = 0
    @upper_right_corner = @size - 1
    @lower_left_corner = (@size * @size) - @size
    @lower_right_corner = (@size * @size) - 1
  end

  def check_board_spot_availability(spot)
    is_not_occupied? @board_positions[spot]
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
      positions << calculate_position_on_square(line, column)
    end
    positions
  end

  def get_positions_for_column column
    positions = []
    (0...@size).each do |line|
      positions << calculate_position_on_square(line, column)
    end
    positions
  end

  def calculate_position_on_square (line, column)
    (line * @size) + column
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
    @board_positions.all? { |space| is_occupied? space }
  end

  def get_available_spaces
    available_spaces = []
    @board_positions.each do |space|
      available_spaces << space if is_not_occupied? space
    end
    available_spaces
  end

  def is_occupied? space
    space == @player1_mark || space == @player2_mark
  end
  
  def is_not_occupied? space
    space != @player1_mark && space != @player2_mark
  end

  def is_corner_occupied? corner
    return :empty if is_not_occupied? @board_positions[corner]
    :occupied
  end
  
  def check_upper_left_corner
    is_corner_occupied? @upper_left_corner
  end
  
  def check_upper_right_corner
    is_corner_occupied? @upper_right_corner
  end
  
  def check_lower_left_corner
    is_corner_occupied? @lower_left_corner
  end
  
  def check_lower_right_corner
    is_corner_occupied? @lower_right_corner
  end
end

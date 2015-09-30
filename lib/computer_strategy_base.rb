module ComputerStrategyBase

  def check_threatening(board, player_mark)
    available_spaces = board.get_available_spaces
    available_spaces.each do |as|
      left_to_assign = available_spaces - [as]
      board.occupy_spot as.to_i, player_mark
      left_to_assign.each do |cell|
        board.occupy_spot cell.to_i, player_mark
        if board.at_least_one_line_the_same
          board.occupy_spot as.to_i, as
          board.occupy_spot cell.to_i, cell
          return as.to_i
        end
        board.occupy_spot cell.to_i, cell
      end

      board.occupy_spot as.to_i, as
    end
    nil
  end        
  
  def check_possible_score(board, player_mark)
    available_spaces = board.get_available_spaces
    available_spaces.each do |as|
      board.occupy_spot as.to_i, player_mark
      if board.at_least_one_line_the_same
        board.occupy_spot as.to_i, as
        return as.to_i
      else
        board.occupy_spot as.to_i, as
      end
    end
    nil     
  end
  
  def check_possible_fork(board, player_mark)
    available_spaces = board.get_available_spaces
    available_spaces.each do |as|
      left_to_assign = available_spaces - [as]
      board.occupy_spot as.to_i, player_mark
      sum = 0
      left_to_assign.each do |cell|
        board.occupy_spot cell.to_i,  player_mark
        if board.at_least_one_line_the_same
          sum += 1
        end
        board.occupy_spot cell.to_i, cell
      end
      board.occupy_spot as.to_i, as
      if sum > 1
        return as.to_i
      end
    end

    nil
  end    

  def check_other_threatening(board, player_mark)
    available_spaces = board.get_available_spaces
    available_spaces.each do |as|
      board.occupy_spot as.to_i, player_mark
      if board.at_least_one_line_the_same
        board.occupy_spot as.to_i, as
        return as.to_i
      else
        board.occupy_spot as.to_i, as
      end
    end
    nil
  end

  def select_first_move(available_spaces)
    # Perfect strategy when going first means using a corner
    # The actual corner doesn't matter, as the board will provide symmetrical plays
    if available_spaces.length == 9
      return 2
    end

    # Perfect strategy when going second use corner if other player_mark chooses center
    if available_spaces.length == 8 and (available_spaces.include? "4")
      return 4
    end

    # Perfect strategy when going second use center if other player_mark chooses something different
    if available_spaces.length == 8
      return 2
    end
  end
end

# This is a hard to beat strategy for a computer controlled player
# For the first move uses a well-established rule for the first move
# It expects to yield to a block that will check if the game is finished or not
# For that yield it will pass the state of the board after a possibe move has been chosen
class ComputerStrategyHard
  def get_move(board, next_player, com, hum)
    available_spaces = []
    board.each do |s|
      if s != com && s != hum
        available_spaces << s
      end
    end

    first_move = select_first_move(available_spaces) if available_spaces.length >= 8

    return first_move if first_move

    possible_move = check_possible_score(board, com, available_spaces, &Proc.new)

    return possible_move if possible_move

    possible_move = check_other_threatening(board, hum, available_spaces, &Proc.new)

    return possible_move if possible_move

    possible_move = check_possible_fork(board, com, available_spaces, &Proc.new)

    return possible_move if possible_move

    possible_move = check_threatening(board, com, available_spaces, &Proc.new)

    return possible_move if possible_move
    
    n = rand(0..available_spaces.count)
    return available_spaces[n].to_i

  end

  def check_threatening(board, player, available_spaces)
    available_spaces.each do |as|
      left_to_assign = available_spaces - [as]
      board[as.to_i] = player
      left_to_assign.each do |cell|
        board[cell.to_i] = player
        if yield board
          board[cell.to_i] = cell
          return as.to_i
        end
        board[cell.to_i] = cell
      end

      board[as.to_i] = as
    end
    nil
  end    
    
  
  def check_possible_score(board, player, available_spaces)
    available_spaces.each do |as|
      board[as.to_i] = player
      if yield board
        board[as.to_i] = as
        return as.to_i
      else
        board[as.to_i] = as
      end
    end
    nil     
  end
  
  def check_possible_fork(board, player, available_spaces)
    available_spaces.each do |as|
      left_to_assign = available_spaces - [as]
      board[as.to_i] = player
      sum = 0
      left_to_assign.each do |cell|
        board[cell.to_i] = player
        if yield board
          sum += 1
        end
        board[cell.to_i] = cell
      end
      board[as.to_i] = as
      if sum > 1
        return as.to_i
      end
    end

    nil
  end    

  def check_other_threatening(board, player, available_spaces)
    available_spaces.each do |as|
      board[as.to_i] = player
      if yield board
        board[as.to_i] = as
        return as.to_i
      else
        board[as.to_i] = as
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

    # Perfect strategy when going second use corner if other player chooses center
    if available_spaces.length == 8 and (available_spaces.include? "4")
      return 4
    end

    # Perfect strategy when going second use center if other player chooses something different
    if available_spaces.length == 8
      return 2
    end
  end
end

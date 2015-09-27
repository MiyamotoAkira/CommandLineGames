# This is an easy difficulty  to beat strategy for a computer controlled player
# It will try to score at the first option, disregarding the actions of the player.
# Unlike the hard strategy it will not try to fork. Unlike the medium strategy it will not block
# It expects to yield to a block that will check if the game is finished or not
# For that yield it will pass the state of the board after a possibe move has been chosen
class ComputerStrategyEasy
  def get_available_spaces(board, com, hum)
    available_spaces = []
    board.each do |s|
      if s != com && s != hum
        available_spaces << s
      end
    end
    available_spaces
  end
  
  def get_move(board, next_player, com, hum)
    available_spaces = get_available_spaces(board, com, hum)

    possible_move = check_possible_score(board, com, available_spaces, &Proc.new)

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
          board[as.to_i] = as
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
end

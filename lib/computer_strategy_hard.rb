# This is a hard to beat strategy for a computer controlled player
# For the first move uses a well-established rule for the first move
# It expects to yield to a block that will check if the game is finished or not
# For that yield it will pass the state of the board after a possibe move has been chosen
class ComputerStrategyHard
  def get_move(board, next_player, com, hum, depth = 0, best_score = {})
    available_spaces = []
    best_move = nil
    board.each do |s|
      if s != com && s != hum
        available_spaces << s
      end
    end

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
    
    available_spaces.each do |as|
      board[as.to_i] = com
      if yield board
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = hum
        if yield board
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = as
        end
      end
    end
    if best_move
      return best_move
    else
      n = rand(0..available_spaces.count)
      return available_spaces[n].to_i
    end
  end
end

class ComputerStrategyHard
  def get_move(board, next_player, com, hum, depth = 0, best_score = {})
    available_spaces = []
    best_move = nil
    board.each do |s|
      if s != com && s != hum
        available_spaces << s
      end
    end
    if available_spaces.include? "4"
      return 4
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

require_relative 'computer_strategy_base'

# This is a medium difficulty  to beat strategy for a computer controlled player
# It will always try to go for center.
# Unlike the hard strategy it will not try to fork.
# It expects to yield to a block that will check if the game is finished or not
# For that yield it will pass the state of the board after a possibe move has been chosen
class ComputerStrategyMedium
  include ComputerStrategyBase
  def get_move(board, this_players_mark, other_players_mark)
    available_spaces = get_available_spaces(board, this_players_mark, other_players_mark)

    first_move = select_first_move(available_spaces) if available_spaces.length >= 8

    return first_move if first_move

    possible_move = check_possible_score(board, this_players_mark, available_spaces, &Proc.new)

    return possible_move if possible_move

    possible_move = check_other_threatening(board, other_players_mark, available_spaces, &Proc.new)

    return possible_move if possible_move

    n = rand(0..available_spaces.count)
    return available_spaces[n].to_i

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
  
  def select_first_move(available_spaces)
    if available_spaces.length == 9 or available_spaces.include? "4"
      return 4
    end
  end
end

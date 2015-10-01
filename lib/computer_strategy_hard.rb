require_relative 'computer_strategy_base'

# This is a hard to beat strategy for a computer controlled player
# For the first move uses a well-established rule for the first move
# It expects to yield to a block that will check if the game is finished or not
# For that yield it will pass the state of the board after a possibe move has been chosen
class ComputerStrategyHard
  include ComputerStrategyBase
  def get_move(board, this_players_mark, other_players_mark)
    available_spaces = board.get_available_spaces

    first_move = select_first_move(available_spaces) if available_spaces.length >= 8

    return first_move if first_move

    possible_move = check_possible_score(board, this_players_mark)

    return possible_move if possible_move

    possible_move = check_other_threatening(board, other_players_mark)

    return possible_move if possible_move

    possible_move = check_possible_fork(board, this_players_mark)

    return possible_move if possible_move

    possible_move = check_threatening(board, this_players_mark)

    return possible_move if possible_move
    
    n = rand(0..available_spaces.count)
    return available_spaces[n].to_i
  end

  def to_s
    "Computer Hard"
  end
end

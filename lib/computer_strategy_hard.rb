require_relative 'computer_strategy_base'

# This is a hard to beat strategy for a computer controlled player
# For the first move uses a well-established rule for the first move
# It expects to yield to a block that will check if the game is finished or not
# For that yield it will pass the state of the board after a possibe move has been chosen
class ComputerStrategyHard <ComputerStrategyBase
  def get_move(board, next_player, com, hum)
    available_spaces = get_available_spaces(board, com, hum)

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
end

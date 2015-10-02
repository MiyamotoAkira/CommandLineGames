require_relative 'computer_strategy_base'

# This is an easy difficulty  to beat strategy for a computer controlled player
# It will try to score at the first option, disregarding the actions of the player.
# Unlike the hard strategy it will not try to fork. Unlike the medium strategy it will not block
# It expects to yield to a block that will check if the game is finished or not
# For that yield it will pass the state of the board after a possibe move has been chosen
class ComputerStrategyEasy
  include ComputerStrategyBase
  
  def get_move(board, this_players_mark, other_players_mark)
    available_spaces = board.get_available_spaces

    possible_move = check_possible_score(board, this_players_mark)

    return possible_move if possible_move

    return get_random available_spaces
  end

  def to_s
    "Computer Easy"
  end
end

require_relative 'computer_base'

# This is a hard to beat strategy for a computer controlled player
# For the first move uses a well-established rule for the first move
# It expects to yield to a block that will check if the game is finished or not
# For that yield it will pass the state of the board after a possibe move has been chosen
module Strategy
  class ComputerHard
    include ComputerBase
    def get_move(board, this_players_mark, other_players_mark)
      available_spaces = board.get_available_spaces

      first_move = select_first_move(available_spaces, board) if available_spaces.length >= 8

      return first_move if first_move

      possible_move = check_possible_score(board, this_players_mark)

      return possible_move if possible_move

      possible_move = check_other_threatening(board, other_players_mark)

      return possible_move if possible_move

      possible_move = check_possible_fork(board, this_players_mark)

      return possible_move if possible_move

      possible_move = check_threatening(board, this_players_mark)

      return possible_move if possible_move
      
      return get_random(available_spaces)
    end

    def to_s
      "Computer Hard"
    end

    def select_first_move(available_spaces, board)
      #Return corner as perfect strategy
      if all_spaces_available? available_spaces
        return 2
      end

      # Stop the chance of an easy fork
      if is_corner_occupied? board
        return get_opposing_corner board
      end

      # Perfect strategy when going second use center if other player_mark chooses something different
      if moving_second? available_spaces
        return 2
      end
    end

    def moving_second?(available_spaces)
      available_spaces.length == 8
    end

    def all_spaces_available?(available_spaces)
      available_spaces.length == 9
    end

    def is_corner_occupied? board
      return board.check_upper_left_corner == :occupied || board.check_upper_right_corner == :occupied || board.check_lower_left_corner == :occupied || board.check_lower_right_corner == :occupied
    end

    def get_opposing_corner board
      return board.lower_right_corner if board.check_upper_left_corner == :occupied
      return board.lower_left_corner if board.check_upper_right_corner == :occupied
      return board.upper_right_corner if board.check_lower_left_corner == :occupied
      return board.upper_left_corner if board.check_lower_right_corner == :occupied
    end
  end
end

require_relative 'computer_base'

# This is a medium difficulty  to beat strategy for a computer controlled player
# It will always try to go for center.
# Unlike the hard strategy it will not try to fork.
# It expects to yield to a block that will check if the game is finished or not
# For that yield it will pass the state of the board after a possibe move has been chosen
module Strategy
  class ComputerMedium
    include ComputerBase
    def get_move(board, this_players_mark, other_players_mark)
      available_spaces = board.get_available_spaces

      first_move = select_first_move(available_spaces) if available_spaces.length >= 8

      return first_move if first_move

      possible_move = check_possible_score(board, this_players_mark)

      return possible_move if possible_move

      possible_move = check_other_threatening(board, other_players_mark)

      return possible_move if possible_move

      return get_random available_spaces
    end

    def check_possible_score(board, player)
      available_spaces = board.get_available_spaces
      available_spaces.each do |as|
        board.occupy_spot as.to_i, player
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
      if available_spaces.length == 9 or available_spaces.include? "4"
        return 4
      end
    end

    def to_s
      "Computer Medium"
    end
  end
end

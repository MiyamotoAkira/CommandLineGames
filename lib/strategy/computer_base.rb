module Strategy
  module ComputerBase

    def check_threatening(board, player_mark)
      available_spaces = board.get_available_spaces
      available_spaces.each do |space|
        left_to_assign = available_spaces - [space]
        board.occupy_spot space.to_i, player_mark
        left_to_assign.each do |cell|
          board.occupy_spot cell.to_i, player_mark
          if board.at_least_one_line_the_same
            board.occupy_spot space.to_i, space
            board.occupy_spot cell.to_i, cell
            return space.to_i
          end
          board.occupy_spot cell.to_i, cell
        end

        board.occupy_spot space.to_i, space
      end
      nil
    end        
    
    def check_possible_score(board, player_mark)
      available_spaces = board.get_available_spaces
      available_spaces.each do |space|
        board.occupy_spot space.to_i, player_mark
        if board.at_least_one_line_the_same
          board.occupy_spot space.to_i, space
          return space.to_i
        else
          board.occupy_spot space.to_i, space
        end
      end
      nil     
    end
    
    def check_possible_fork(board, player_mark)
      available_spaces = board.get_available_spaces
      available_spaces.each do |space|
        left_to_assign = available_spaces - [space]
        board.occupy_spot space.to_i, player_mark
        sum = 0
        left_to_assign.each do |cell|
          board.occupy_spot cell.to_i,  player_mark
          if board.at_least_one_line_the_same
            sum += 1
          end
          board.occupy_spot cell.to_i, cell
        end
        board.occupy_spot space.to_i, space
        if sum > 1
          return space.to_i
        end
      end

      nil
    end    

    def check_other_threatening(board, player_mark)
      available_spaces = board.get_available_spaces
      available_spaces.each do |space|
        board.occupy_spot space.to_i, player_mark
        if board.at_least_one_line_the_same
          board.occupy_spot space.to_i, space
          return space.to_i
        else
          board.occupy_spot space.to_i, space
        end
      end
      nil
    end

    def get_random(available_spaces)
      n = rand(0..(available_spaces.count-1))
      return available_spaces[n].to_i
    end
  end
end

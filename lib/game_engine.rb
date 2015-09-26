require_relative 'computer_strategy_hard'

class GameEngine
  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @com = "X"
    @hum = "O"
  end

  def start_game
    system "clear" or system "cls"
    puts "Welcome to my Tic Tac Toe game"
    puts ""
    puts "|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
    puts "Please select your spot."
    until game_is_over(@board) || tie(@board)
      human_spot = get_human_spot
      machine_spot = nil
      if !game_is_over(@board) && !tie(@board)
        machine_spot = eval_board
      end
      system "clear" or system "cls"
      puts "The user has chosen spot #{human_spot}"
      if machine_spot
        puts "The computer has chosen spot #{machine_spot}"
      else
        puts ""
      end
      puts "|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
      puts "Please select your spot."
    end
    puts "Game over"
  end

  def get_human_input
    gets.chomp
  end

  def get_human_spot
    spot = nil
    until spot
      input = get_human_input
      if validate_input(input)
        spot = input.to_i
        if check_board_spot_availability(spot)
          @board[spot] = @hum
        else
          spot = nil
        end
      end
    end
    spot
  end

  def check_board_spot_availability(spot)
    @board[spot] != @com && @board[spot] != @hum
  end

  def validate_input(input)
    if input =~ /^[0-9]{1}$/
      true
    else
      false
    end
  end

  def eval_board
    spot = nil
    until spot
      computer = ComputerStrategyHard.new
      spot = computer.get_move(@board, @com, @com, @hum) { |board| game_is_over(board)}
      if check_board_spot_availability(spot)
        @board[spot] = @com
      else
        spot = nil
      end
    end
    spot
  end

  def game_is_over(b)

    [b[0], b[1], b[2]].uniq.length == 1 ||
    [b[3], b[4], b[5]].uniq.length == 1 ||
    [b[6], b[7], b[8]].uniq.length == 1 ||
    [b[0], b[3], b[6]].uniq.length == 1 ||
    [b[1], b[4], b[7]].uniq.length == 1 ||
    [b[2], b[5], b[8]].uniq.length == 1 ||
    [b[0], b[4], b[8]].uniq.length == 1 ||
    [b[2], b[4], b[6]].uniq.length == 1
  end

  def tie(b)
    b.all? { |s| s == "X" || s == "O" }
  end
end

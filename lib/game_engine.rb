class GameEngine
  def initialize (player1, player2)
    @player1 = player1
    @player2 = player2
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @player2_mark = "X"
    @player1_mark = "O"
  end

  def start_game
    system "clear" or system "cls"
    puts "Welcome to my Tic Tac Toe game"
    puts ""
    puts "|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
    puts "Please select your spot."
    until game_is_over(@board) || tie(@board)
      player1_spot = get_player_spot(@player1, @player1_mark)
      player2_spot = nil
      if !game_is_over(@board) && !tie(@board)
        player2_spot = get_player_spot(@player2, @player2_mark)
      end
      system "clear" or system "cls"
      puts "Player 1  has chosen spot #{player1_spot}"
      if player2_spot
        puts "Player 2 has chosen spot #{player2_spot}"
      else
        puts ""
      end
      puts "|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
      puts "Please select your spot."
    end
    puts "Game over"
    gets
  end


  def get_player_spot (player, player_mark)
    spot = nil
    until spot
      spot = player.get_move(@board, @player1_mark, @player2_mark) {|board| game_is_over(board)}
      if check_board_spot_availability(spot)
        @board[spot] = player_mark
      else
        spot = nil
      end
    end
    spot
  end

  def check_board_spot_availability(spot)
    @board[spot] != @com && @board[spot] != @hum
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

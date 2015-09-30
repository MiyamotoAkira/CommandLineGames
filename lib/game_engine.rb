class GameEngine
  def initialize (player1, player2, marks)
    @player1 = player1
    @player2 = player2
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @player1_mark = marks[:player1_mark]
    @player2_mark = marks[:player2_mark]
  end

  def start_game
    clear_screen
    puts "Welcome to my Tic Tac Toe game"
    puts ""
    first_player = true
    previous_move = nil
    until game_is_over(@board) || tie(@board)
      output_board
      puts "Please select your spot."
      player, player_mark = change_player first_player
      player_spot = get_player_spot(player, player_mark)
      clear_screen
      previous_move = show_selections player_spot, first_player,  previous_move
      first_player = !first_player
    end
    output_board
    puts "Game over"
    puts "Press a key"
    gets
  end

  def change_player firstPlayer
    if firstPlayer == true
      [@player1, @player1_mark]
    else
      [@player2, @player2_mark]
    end
  end
  
  def show_selections player_spot, first_player, previous_move
    if previous_move
      puts previous_move
    else
      puts ""
    end
    number = first_player ? "1" : "2"
    sentence = "Player #{number}  has chosen spot #{player_spot}"
    puts sentence
    sentence
  end
  
  def clear_screen
    system "clear" or system "cls"
  end
  
  def output_board
    puts "|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
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
    @board[spot] != @player1_mark && @board[spot] != @player2_mark
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

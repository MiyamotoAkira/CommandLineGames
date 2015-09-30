class GameEngine
  def initialize (player1, player2, marks, io)
    @player1 = player1
    @player2 = player2
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @player1_mark = marks[:player1_mark]
    @player2_mark = marks[:player2_mark]
    @io = io
  end

  def start_game
    @io.clear_screen
    @io.welcome
    first_player = true
    until game_is_over(@board) || tie(@board)
      @io.output_board @board
      @io.select_spot_info
      player, player_mark = change_player first_player
      player_spot = get_player_spot(player, player_mark)
      @io.clear_screen
      @io.show_selections player_spot, first_player
      first_player = !first_player
    end
    @io.output_board @board
    @io.end_of_game
  end

  def change_player firstPlayer
    if firstPlayer == true
      [@player1, @player1_mark]
    else
      [@player2, @player2_mark]
    end
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

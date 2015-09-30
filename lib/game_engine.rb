require_relative 'board'
class GameEngine
  def initialize (player1, player2, marks, io)
    @player1 = player1
    @player2 = player2
    @player1_mark = marks[:player1_mark]
    @player2_mark = marks[:player2_mark]
    @board = Board.new @player1_mark, @player2_mark
    @io = io
  end

  def start_game
    @io.clear_screen
    @io.welcome
    first_player = true
    until game_is_over || tie
      @io.output_board @board.board_positions
      @io.select_spot_info
      player, player_mark = change_player first_player
      player_spot = get_player_spot(player, player_mark)
      @io.clear_screen
      @io.show_selections player_spot, first_player
      first_player = !first_player
    end
    @io.output_board @board.board_positions
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
      if @board.check_board_spot_availability(spot)
        @board.occupy_spot spot, player_mark
      else
        spot = nil
      end
    end
    spot
  end

  def game_is_over
    @board.at_least_one_line_the_same
  end

  def tie
    @board.tie
  end
end

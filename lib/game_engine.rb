require_relative 'board'
class GameEngine
  def initialize (player1, player2, io)
    @player1 = player1
    @player2 = player2
    @board = Board.new @player1.mark, @player2.mark
    @io = io
  end

  def start_game
    @io.clear_screen
    @io.welcome
    first_player = true
    until game_is_over || tie
      @io.output_board @board.board_positions
      @io.select_spot_info
      player  = change_player first_player
      player_spot = get_player_spot(player)
      @io.clear_screen
      @io.show_selections player_spot, first_player
      first_player = !first_player
    end
    @io.output_board @board.board_positions
    @io.end_of_game
  end

  def change_player firstPlayer
    if firstPlayer == true
      @player1
    else
      @player2
    end
  end    

  def get_player_spot (player)
    spot = nil
    until spot
      spot = player.get_move(@board, @player1.mark, @player2.mark) 
      if @board.check_board_spot_availability(spot)
        @board.occupy_spot spot, player.mark
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

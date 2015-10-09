require_relative 'board'
class GameEngine
  def initialize (player1, player2, io)
    @player1 = player1
    @player2 = player2
    @board = Board.new @player1.mark, @player2.mark
    @io = io
  end

  def start_screen
    @io.clear_screen
    @io.welcome
  end

  def end_of_game_screen is_first_player
    @io.output_board @board.board_positions
    if tie
      @io.is_a_tie
    else
      @io.player_won (is_first_player ? 2 : 1)
    end
    @io.end_of_game
  end
  
  def start_game
    start_screen
    is_first_player = true
    until game_is_over || tie
      is_first_player  = process_move is_first_player
    end
    end_of_game_screen is_first_player
  end

  def process_move is_first_player
    @io.output_board @board.board_positions
    @io.select_spot_info
    player  = change_player is_first_player
    player_spot = get_player_spot(player)
    @io.clear_screen
    @io.show_selections player_spot, is_first_player
    !is_first_player
  end

  def change_player is_first_player
    if is_first_player
      @player1
    else
      @player2
    end
  end    

  def get_player_spot (player)
    spot = nil
    until spot
      spot = player.get_move(@board, @player1.mark, @player2.mark)
      if spot != nil
        if @board.check_board_spot_availability(spot)
          @board.occupy_spot spot, player.mark
        else
          spot = nil
        end
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

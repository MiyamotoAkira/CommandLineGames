require_relative 'game_engine'
require_relative 'game_menu'
require_relative 'game_io'
require_relative 'computer_strategy_hard'
require_relative 'computer_strategy_medium'
require_relative 'computer_strategy_easy'
require_relative 'human_player'

class Game
  def initialize
    @player1 = :human
    @player2 = :human
    @marks = { player1_mark: 'O', player2_mark: 'X' }
  end
  
  def show_menu
    @menu = GameMenu.new GameIO.new
    option_chosen = :unknown
    while option_chosen != :exit
      @menu.show_main_menu
      option_chosen = @menu.get_option_main
      case option_chosen
      when :start
        start_game
      when :player1
        @player1 = show_players
      when :player2
        @player2 = show_players
      when :marks
        show_marks
      end
    end
  end

  def show_players
    @menu.show_players_menu
    option_chosen = :unknown
    while option_chosen == :unknown
      option_chosen = @menu.get_option_players
    end
    option_chosen
  end

  def show_marks
    @menu.show_marks_menu
    option_chosen = :unknown
    while option_chosen == :unknown
      option_chosen = @menu.get_option_marks
    end
    new_mark = @menu.get_mark
    @marks[option_chosen] = new_mark
  end

  def get_player player
    case player
    when :human
      HumanPlayer.new GameIO.new
    when :easy
      ComputerStrategyEasy.new
    when :medium
      ComputerStrategyMedium.new
    when :hard
      ComputerStrategyHard.new
    end
  end
  
  def start_game
    player1 = get_player @player1
    player2 = get_player @player2
    engine = GameEngine.new player1, player2, @marks, GameIO.new
    engine.start_game
  end
end

game = Game.new
game.show_menu

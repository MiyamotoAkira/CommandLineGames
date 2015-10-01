require_relative 'game_engine'
require_relative 'game_menu'
require_relative 'game_io'
require_relative 'computer_strategy_hard'
require_relative 'computer_strategy_medium'
require_relative 'computer_strategy_easy'
require_relative 'human_player'
require_relative 'player'

class Game
  def initialize
    @players = {player1: Player.new(get_player(:human), 'X'), player2: Player.new(get_player(:human), 'O')}
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
        show_players :player1
      when :player2
        show_players :player2
      when :marks
        show_marks
      end
    end
  end

  def show_players player
    @menu.show_players_menu
    option_chosen = :unknown
    while option_chosen == :unknown
      option_chosen = @menu.get_option_players
    end
    @players[player].type = get_player option_chosen
  end

  def show_marks
    @menu.show_marks_menu
    option_chosen = :unknown
    while option_chosen == :unknown
      option_chosen = @menu.get_option_marks
    end
    new_mark = @menu.get_mark
    @players[option_chosen].mark = new_mark
  end

  def get_player type
    case type
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
    engine = GameEngine.new @players[:player1], @players[:player2], GameIO.new
    engine.start_game
  end
end

game = Game.new
game.show_menu

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
      @menu.show_main_menu @players[:player1], @players[:player2]
      option_chosen = @menu.get_option_main
      case option_chosen
      when :start
        start_game
      when :player1
        show_player_change :player1
      when :player2
        show_player_change :player2
      end
    end
  end

  def show_player_change player
    @menu.show_options_player_change_menu
    option_chosen = :unknown
    while option_chosen == :unknown
      option_chosen = @menu.get_option_player_change
    end
    case option_chosen
    when :type
      @menu.show_player_type_menu
      option_chosen = :unknown
      while option_chosen == :unknown
        option_chosen = @menu.get_option_player_type
      end
      @players[player].type = get_player option_chosen
    when :mark
      new_mark = @menu.get_mark
      @players[player].mark = new_mark
    end
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

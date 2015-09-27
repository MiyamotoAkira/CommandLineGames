require_relative 'game_engine'
require_relative 'game_menu'
require_relative 'game_io'
require_relative 'computer_strategy_hard'
require_relative 'computer_strategy_medium'
require_relative 'computer_strategy_easy'

class Game
  def initialize
    @difficulty_level = :hard
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
      when :difficulty
        show_difficulty
      end
    end
  end
  
  def show_difficulty
    @menu.show_difficulty_menu
    option_chosen = :unknown
    while option_chosen == :unknown
      option_chosen = @menu.get_option_difficulty
    end
    @difficulty_level = option_chosen
  end

  def get_computer_player
    case @difficulty_level
    when :easy
      ComputerStrategyEasy.new
    when :medium
      ComputerStrategyMedium.new
    when :hard
      ComputerStrategyHard.new
    end
  end
  
  def start_game
    computer = get_computer_player
    engine = GameEngine.new computer
    engine.start_game
  end
end

game = Game.new
game.show_menu

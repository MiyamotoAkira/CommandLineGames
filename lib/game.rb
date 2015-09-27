require_relative 'game_engine'
require_relative 'game_menu'
require_relative 'game_io'

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
  
  def start_game
    engine = GameEngine.new
    engine.start_game
  end
end

game = Game.new
game.show_menu

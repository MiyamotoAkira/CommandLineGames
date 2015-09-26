require_relative 'game_engine'

class Game
  def start_game
    engine = GameEngine.new
    engine.start_game
  end
end

game = Game.new
game.start_game

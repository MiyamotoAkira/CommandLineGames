class Player

  attr_accessor :type, :mark

  def initialize type, mark
    @type = type
    @mark = mark
  end
  
  def get_move(board, this_players_mark, other_players_mark)
    @type.get_move(board, this_players_mark, other_players_mark)
  end
end

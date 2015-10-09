class HumanStrategy
  def initialize(io)
    @io = io
  end
  
  def get_move(board, this_players_mark, other_players_mark)
      input = @io.get_input
      if validate_input(input)
        input.to_i
      else
        nil
      end
  end

  def validate_input(input)
    if input =~ /^[0-9]{1}$/
      true
    else
      false
    end
  end

  def to_s
    "Human"
  end
end

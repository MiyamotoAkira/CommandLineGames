class GameMenu
  def initialize(io)
    @io = io
  end
  
  def show_main_menu player1, player2
    @io.clear_screen
    messages = []
    messages << "This is Tic Tac Toe"
    messages << "Select an option:"    
    messages << "1 - Start a game"
    messages << "2 - Player 1: #{player1.type}, mark: #{player1.mark}"
    messages << "3 - Player 2: #{player2.type}, mark: #{player2.mark}"
    messages << "9 - Exit the game"
    @io.output_messages messages
  end

  def show_player_type_menu
    @io.clear_screen
    messages = []
    messages << "Select an option:"
    messages << "1 - Human"
    messages << "2 - Computer Easy"
    messages << "3 - Computer Medium"
    messages << "4 - Computer Hard"
    @io.output_messages messages
  end

  def show_options_player_change_menu
    @io.clear_screen
    messages = []
    messages << "Select an option:"
    messages << "1 - Change player type"
    messages << "2 - Change player mark"
    @io.output_messages messages    
  end

  def get_option_player_change
    input = @io.get_input_as_int
    case input
    when 1
      :type
    when 2
      :mark
    else
      :unknown
    end
  end
  
  def get_option_main
    input = @io.get_input_as_int
    case input
    when 1
      :start
    when 2
      :player1
    when 3
      :player2
    when 9
      :exit
    else
      :unknown
    end
  end


  def get_option_player_type
    input = @io.get_input_as_int
    case input
    when 1
      :human
    when 2
      :easy
    when 3
      :medium
    when 4
      :hard
    else
      :unknown
    end
  end

  def get_mark
    new_mark = nil
    until new_mark
      puts "Introduce new mark:"
      new_mark = @io.get_input
      unless validate_mark(new_mark)
        new_mark = nil
      end
    end
    new_mark
  end

  def validate_mark possible_mark
    if /[0-9\|_]|.{2}/ =~ possible_mark
      false
    else
      true
    end
  end
end

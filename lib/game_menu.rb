class GameMenu
  def initialize(io)
    @io = io
  end
  
  def show_main_menu player1, player2
    system "clear" or system "cls"
    puts "This is Tic Tac Toe"
    puts "Select an option:"
    puts "1 - Start a game"
    puts "2 - Player 1: #{player1.type}, mark: #{player1.mark}"
    puts "3 - Player 2: #{player2.type}, mark: #{player2.mark}"
    puts "9 - Exit the game"
  end

  def show_player_type_menu
    system "clear" or system "cls"
    puts "Select an option:"
    puts "1 - Human"
    puts "2 - Computer Easy"
    puts "3 - Computer Medium"
    puts "4 - Computer Hard"
  end

  def show_options_player_change_menu
    system "clear" or system "cls"
    puts "Select an option:"
    puts "1 - Change player type"
    puts "2 - Change player mark"
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

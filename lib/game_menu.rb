class GameMenu
  def initialize(io)
    @io = io
  end
  
  def show_main_menu
    system "clear" or system "cls"
    puts "This is Tic Tac Toe"
    puts "Select an option:"
    puts "1 - start a game"
    puts "2 - Select computer difficulty"
    puts "3 - Select players"
    puts "9 - Exit the game"
  end

  def show_difficulty_menu
    system "clear" or system "cls"
    puts "Select an option:"
    puts "1 - Hard"
    puts "2 - Medium"
    puts "3 - Easy"
  end

  def show_players_menu
    system "clear" or system "cls"
    puts "Select an option:"
    puts "1 - Human vs Human"
    puts "2 - Computer vs Computer"
    puts "3 - Human vs Computer"
  end

  def get_option_players
    input = @io.get_input_as_int
    case input
    when 1
      :twohum
    when 2
      :twocomp
    when 9
      :humandcomp
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
      :difficulty
    when 3
      :players
    when 9
      :exit
    else
      :unknown
    end
  end

  def get_option_difficulty
    input = @io.get_input_as_int
    case input
    when 1
      :hard
    when 2
      :medium
    when 3
      :easy
    else
      :unknown
    end
  end
end

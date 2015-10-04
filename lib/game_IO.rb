class GameIO
  def get_input
    gets.chomp
  end

  def get_input_as_int
    gets.chomp.to_i
  end

  def player_won player_number
    puts "Player #{player_number} has won!"
  end
  
  def end_of_game
    puts "Game over"
    puts "Press a key"
    gets
  end

  def welcome
    puts "Welcome to my Tic Tac Toe game"
    puts ""
  end

    def clear_screen
    system "clear" or system "cls"
  end

  def output_board board
    puts "|_#{board[0]}_|_#{board[1]}_|_#{board[2]}_|\n|_#{board[3]}_|_#{board[4]}_|_#{board[5]}_|\n|_#{board[6]}_|_#{board[7]}_|_#{board[8]}_|\n"
  end

  def is_a_tie
    puts "The game is a tie"
  end
  
  def select_spot_info
    puts "Please select your spot."
  end

  def show_selections player_spot, first_player
    if @previous_move
      puts @previous_move
    else
      puts ""
    end
    number = first_player ? "1" : "2"
    sentence = "Player #{number}  has chosen spot #{player_spot}"
    puts sentence
    @previous_move = sentence
  end

  def output_messages messages
    messages.each {|message| puts message}
  end
end

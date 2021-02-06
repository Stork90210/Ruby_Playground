class Player

  attr_accessor :name, :token

  def initialize(name, token)
    @name = name
    @token = token
  end

  def play_turn
  end
  

end

class HumanPlayer < Player
  def initialize
  end

  def pick_name(player_number)
    puts "Hello Player #{player_number}, what's your name?"
    gets.chomp
  end

  def pick_token(name)
    puts "Hi #{name}, choose your token."
    puts "Choose 1 for X or 2 for O"
    choice = gets.chomp.to_i
    if choice == 1
      return "X"
    elsif choice == 2
      return "O"
    else
      puts "\nPlease make a valid choice. 1 or 2!"
      pick_token(name)
    end
  end

  def pick_opponent(name)
    puts "Well #{name}, do you want to play against a human, or the computer?"
    puts "Choose 1 for human or 2 for computer"
    choice = gets.chomp.to_i
    if choice == 1
      return "Human"
    elsif choice == 2
      return "Computer"
    else
      puts "\nPlease make a valid choice. 1 or 2!"
      pick_opponent(name)
    end
  end

end

class ComputerPlayer < Player
  attr_accessor :name
  
  def initialize
    @name = "Computer"
  end

  def pick_token
    player1.pick_token == "X" ? "O" : "X"
  end
  
  def play_turn
  end

end

class Board
  def initialize
    @board = %w[1 2 3 4 5 6 7 8 9]
    @winline1 = board[0] == board[1] && board[1] == board[2]
    @winline2 = board[3] == board[4] && board[4] == board[5]
    @winline3 = board[6] == board[7] && board[7] == board[8]
    @winline4 = board[0] == board[3] && board[3] == board[6]
    @winline5 = board[1] == board[4] && board[4] == board[7]
    @winline6 = board[2] == board[5] && board[5] == board[8]
    @winline7 = board[0] == board[4] && board[4] == board[8]
    @winline8 = board[2] == board[4] && board[4] == board[6]
    @winlines = [@winline1, @winline2, @winline3, @winline4, @winline5, @winline6, @winline7, @winline8]
  end


end


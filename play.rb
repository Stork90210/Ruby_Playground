class Board
  def initialize
    @board = %w[1 2 3 4 5 6 7 8 9]
  end

  def print_board
    puts "\n"
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]}"
    puts '-----------'
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]}"
    puts '-----------'
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]}"
    puts "\n"
  end

  def update_board(place, token)
    if @board.include?(place)
      index = place.to_i - 1
      @board[index] = token
      true
    else
      puts "I'm sorry, this place is not available (anymore), please try again."
      false
    end
  end

  def winner?
    # Checks every winline if it has 3 equal tokens. Didn't feel like a big if-else block. Returns token if found, false if not found.
    @line1 = @board[0] if @board[0] == @board[1] && @board[1] == @board[2]
    @line2 = @board[3] if @board[3] == @board[4] && @board[4] == @board[5]
    @line3 = @board[6] if @board[6] == @board[7] && @board[7] == @board[8]
    @line4 = @board[0] if @board[0] == @board[3] && @board[3] == @board[6]
    @line5 = @board[1] if @board[1] == @board[4] && @board[4] == @board[7]
    @line6 = @board[2] if @board[2] == @board[5] && @board[5] == @board[8]
    @line7 = @board[0] if @board[0] == @board[4] && @board[4] == @board[8]
    @line8 = @board[2] if @board[2] == @board[4] && @board[4] == @board[6]
    line_list = [@line1, @line2, @line3, @line4, @line5, @line6, @line7, @line8]
    if line_list.include?('X')
      'X'
    elsif line_list.include?('O')
      'O'
    else
      false
    end
  end

  def tie?
    #@board.include?("1") || @board.include?("2") || @board.include?("3") || @board.include?("4") || @board.include?("5") || @board.include?("6") || @board.include?("7") || @board.include?("8") || @board.include?("9")
    @board.count("X") + @board.count("O") == 9
  end
end

class Player
  attr_reader :name, :token
  @@total_players = 0
  
  def initialize(name, token)
    @name = name
    @token = token
    @@total_players += 1
  end

  def play_turn(board)
    loop do
      puts "#{@name}, where do you want to put your #{@token}"
      @number = gets.chomp
      if board.update_board(@number, @token) then break
      end
    end
  end
end

class Game
  
  def initialize
    @player1 = Player.new("Johan", "X")
    @player2 = Player.new("Marijke", "O")
    @current_board = Board.new
  end

  def play_game
    until @current_board.winner? || @current_board.tie? 
      @current_board.print_board
      @player1.play_turn(@current_board)
      unless @current_board.winner? || @current_board.tie?
        @current_board.print_board
        @player2.play_turn(@current_board)
      end
    end
      if @current_board.winner? == @player1.token
        puts "Congratulations #{@player1.name}, you've won!"
      elsif @current_board.winner? == @player2.token
        puts "Congratulations #{@player2.name}, you've won!"
      else  
        puts "Rats, it's a tie!"
      end
  end
end

start = Game.new
start.play_game
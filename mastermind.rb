require 'colorize'

class Code
  @@possible_colors = [:red, :green, :yellow, :blue, :magenta, :cyan]
  attr_reader :code, :possible_colors

  def self.possible_colors
    @@possible_colors
  end

  def initialize(code)
    @code = code
  end

  def show
    @dots = code.map { |e| ' ⬤ '.colorize(@@possible_colors[e - 1]) }
    @dots.join(' ')
  end
end

class SecretCode < Code
  def initialize
    @code = [(1...6).to_a.sample, (1...6).to_a.sample, (1...6).to_a.sample, (1...6).to_a.sample]
  end
end

class Guess < Code
  attr_reader :guess, :black, :white
  @@total_guesses = []
  
  def initialize(code)
    @@total_guesses << self
    super(code)
  end

  #Makes class variable total_guesses available
  def self.total_guesses
    @@total_guesses
  end
  
  #Checks secret_code against guess.
  def compare(secret_code)
    @temp_secret_code = secret_code.dup
    @temp_guess = code.dup
    @black = 0
    @white = 0 
    @temp_secret_code.each_with_index do |digit_in_code, i|
      if digit_in_code == @temp_guess[i]
        @black += 1
        @temp_guess[i] = nil
        @temp_secret_code[i] = ' '
      end
    end
    
    @temp_secret_code.each_with_index do |digit_in_code, i|
      if @temp_guess.include?(digit_in_code)
        @white += 1
        @temp_guess[i] = nil
        @temp_secret_code[i] = ' '
      end
    end
    [@black, @white]
  end
end

class Player
  def initialize; end

  #Asks for a code. Shows colors, return array with numbers.
  def ask_for_code
    puts "Which code do you want to enter?"
    color1 = "1 =  ⬤    ".colorize(Code.possible_colors[1 - 1])
    color2 = "2 =  ⬤    ".colorize(Code.possible_colors[2 - 1])
    color3 = "3 =  ⬤    ".colorize(Code.possible_colors[3 - 1])
    color4 = "4 =  ⬤    ".colorize(Code.possible_colors[4 - 1])
    color5 = "5 =  ⬤    ".colorize(Code.possible_colors[5 - 1])
    color6 = "6 =  ⬤    ".colorize(Code.possible_colors[6 - 1])
    puts color1 + color2 + color3 + color4 + color5 + color6
    gets.chomp.to_s.split('').map(&:to_i)
  end

end

class Humanplayer < Player
  def initialize; end

  # Adds guess to array of guesses. Very similar to Class Computerplayer. Maybe combine in Class Player?
  def play_round
    Guess.new(ask_for_code)
    Guess.total_guesses.each do |single_guess|
      puts single_guess.show + single_guess.compare(Game.secret_code)
    end
    puts ""
    puts ""
    puts ""
  end

  #Ask user for making secret code if codemaker. Uses generic ask code method.
  def make_secret_code
    puts "You are the codemaker!"
    ask_for_code
  end
end

class Computerplayer < Player
  def inialize; end
  
  #Computer takes a random guess
  # def play_round
  #   puts "Computerplayer is making a guess..."
  #   Guess.new([(1...6).to_a.sample, (1...6).to_a.sample, (1...6).to_a.sample, (1...6).to_a.sample])
  #   Guess.total_guesses.each do |single_guess|
  #     puts single_guess.show + single_guess.compare(Game.secret_code)
  #   end
  #   puts ""
  #   puts ""
  #   puts ""
  # end

  #Computer makes random code
  def make_secret_code
    [(1...6).to_a.sample, (1...6).to_a.sample, (1...6).to_a.sample, (1...6).to_a.sample]
  end

  def play_round
    @first_guess = Guess.new(@possible_codes.sample)
    @first_pegs = @first_guess.compare(Game.secret_code).dup
    @possible_codes.each do |single_guess|
      unless @first_pegs == @first_guess.compare(single_guess)
        @possible_codes.delete(single_guess)
      end
    end
  end





  #Computer makes a list of possible codes
  def generate_possible_codes
    @possible_codes = Array.new
    (1..6).to_a.each do |first_digit|
      (1..6).to_a.each do |second_digit|
        (1..6).to_a.each do |third_digit|
          (1..6).to_a.each do |fourth_digit|
            @possible_codes.push([first_digit, second_digit, third_digit, fourth_digit])
          end
        end
      end
    end
    @possible_codes
  end
  
end

class Game
  # Max guesses is set here. Maybe prompt for max guesses?
  def initialize
    @max_turns = 50
  end
    #Checks for wincondition (4 blacks) in array of guesses. Should only check last guess?
  def winner?
    @winner = false
    Guess.total_guesses.each do |single_guess|
      if single_guess.black == 4
        @winner = true
      end
    end
    @winner    
  end

  #Prompts user for choice of player. Either Computer or Human. User for codemaker and codebreaker
  def ask_breakermaker(breakormake)
    puts "Should the #{breakormake} be a humanplayer or a computerplayer?"
    puts "Choose 1 for Human, choose 2 for Computer"
    @respons = gets.chomp.to_i
    until (@respons == 1 || @respons == 2)
      puts "Please choose either 1 on 2!"
      @respons = gets.chomp.to_i
    end
    if @respons == 1
      Humanplayer.new
    elsif @respons == 2
      Computerplayer.new      
    else
      puts "This is not a valid response. Please enter 1 or 2!"
    end
  end
  
  #Main logic for game
  def play_game
    @codemaker = ask_breakermaker("codemaker")
    @codebreaker = ask_breakermaker("codebreaker")
    @codebreaker.generate_possible_codes
    @@secret_code = @codemaker.make_secret_code
    until winner? == true || Guess.total_guesses.length == @max_turns
      @codebreaker.play_round
    end
    puts winner? ? "The codebreaker found the secretcode" : "The codebreaker lost!"
  end

  #Make the classvariable @@secret_code available. Should this be a class variable?. Should this even exist?
  def self.secret_code
    @@secret_code
  end

  # Clears the screen.
  def self.cls
    puts "\e[H\e[2J" 
  end
end



game1 = Game.new
game1.play_game

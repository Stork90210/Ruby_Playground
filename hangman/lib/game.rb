class Game
  attr_accessor :all_guesses, :allowed_wrong_guesses, :guesses_remaining, :secret_word, :guess

  def initialize
    @secret_word = SecretWord.new
    @all_guesses = []
    @allowed_wrong_guesses = 12
    @guesses_remaining = @allowed_wrong_guesses
  end

  def save_game
    {'Secret Word' => @secret_word.secret_word, 'All Guesses' => @all_guesses, 'Allowed Wrong Guesses' => @allowed_wrong_guesses, 'Guesses Remaining' => @guesses_remaining}.to_json
  end

  def load_game(string)
    save_game = JSON.parse(string)
    @secret_word = SecretWord.new(save_game['Secret Word'])
    @all_guesses = save_game['All Guesses']
    @allowed_wrong_guesses = save_game['Allowed Wrong Guesses']
    @guesses_remaining = save_game['Guesses Remaining']    
  end

  def print_round
    puts `clear`
    puts "You are looking for the secret word: #{@secret_word.hide_secret_word(@all_guesses)}"
    puts "You have #{@guesses_remaining} guesses left"
    puts "Guesses: #{@all_guesses}"
  end

  def get_guess
    loop do
      puts 'Guess a letter, or input S to save and exit'
      @guess = Guess.new(gets.chomp)
      puts 'You have already tried this letter. Please make a new guess.' unless @guess.unique?(@all_guesses)
      puts 'You can only guess (lowercase) letters. Please make a new guess.' unless @guess.letter?
      puts 'Please enter 1 character at a time. Please make a new guess.' unless @guess.single_char?
      break if @guess.unique?(all_guesses) && @guess.letter? && @guess.single_char?
    end
    @guess.new_guess
  end

  def update_guesses_remaining
    @guesses_remaining -= 1 unless @secret_word.secret_word.include?(@guess.new_guess)
  end

  def win?
    !@secret_word.hide_secret_word(@all_guesses).include?('_')
  end

  def lost?
    !@guesses_remaining.positive?
  end
end

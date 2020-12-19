class Guess
  attr_reader :new_guess

  def initialize(guess)
    @new_guess = guess
  end

  def update_guess(all_guesses)
    all_guesses << @new_guess
  end

  def unique?(all_guesses)
    !all_guesses.include?(@new_guess)
  end

  def single_char?
    @new_guess.length == 1
  end

  def letter?
    @all_letters = ('a'..'z').to_a + ['S']
    @all_letters.include?(@new_guess)
  end

  def save?
    @new_guess == "S"
  end
end

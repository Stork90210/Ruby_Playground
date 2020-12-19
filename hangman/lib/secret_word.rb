class SecretWord
  attr_accessor :secret_word

  def initialize(secret = pick_word)
    # secret_word.clean_up_file
    @secret_word = secret
  end

  # Replaces corrected_wordlist.txt with new version.
  def clean_up_file
    File.delete('corrected_wordlist.txt') if File.exist?('corrected_wordlist.txt') 
    word_list = File.readlines 'wordlist.txt'
    word_list.each do |word|
      File.write('corrected_wordlist.txt', word, mode: 'a') unless word.index(/[^[:alpha:][\n]]/) || word.length > 13 || word.length < 6
    end
  end

  # Returns random entry from corrected_wordlist
  def pick_word
    File.readlines('corrected_wordlist.txt').sample.chomp
  end

  # Returns secret word with non-guesses blanked out.
  def hide_secret_word(guesses)
    split_word = secret_word.chars.map do |letter|
      guesses.include?(letter) ? letter : '_'
    end
    split_word.join
  end
end

require_relative 'guess'
require_relative 'secret_word'
require_relative 'game'
require 'json'

puts 'Welcome to hangman!'
puts ''
puts ''
puts '1. New game'
puts '2. Load game'
puts 'Select type of game'

type_of_game = -1
until type_of_game == 1 || type_of_game == 2
  type_of_game = gets.chomp.to_i
end

if type_of_game == 1
  new_game = Game.new
elsif type_of_game == 2
  new_game = Game.new
  save = File.read('savestate.json')
  new_game.load_game(save)
end

until new_game.lost? || new_game.win?
  new_game.print_round
  guess = new_game.get_guess
  if guess == "S"
    File.write('savestate.json', new_game.save_game)
    break
  else

  new_game.all_guesses << guess
  new_game.update_guesses_remaining
  end

  # File.write('savestate.json', new_game.to_json)
  
end


puts "Unfortunately, you've lost. Please try again!" if new_game.lost?
puts "You've won! The word was #{new_game.secret_word.secret_word}" if new_game.win?
require 'pp'

class Bingocard
  attr_accessor :bingo_card

  def initialize(card_size, total_selection)
    @card_size = card_size
    @total_selection = total_selection
    @bingo_card = (1..total_selection).to_a.sample(card_size)
  end

  def cross_of_list(number)
    if @bingo_card.include?(number)
      @bingo_card[@bingo_card.index(number)] = 'X'
    end
  end

  def count_remaining()
    @card_size - @bingo_card.count('X')
  end

  def count_hits()
    @bingo_card.count('X')
  end

end

class Bingogame
  attr_accessor :list_of_cards, :number_drawn, :bingo_histogram
  
  def initialize(card_size, total_selection, number_of_cards)
    @card_size = card_size
    @number_of_cards = number_of_cards
    @total_selection = total_selection
    @remaining_balls = (1..total_selection).to_a
  end

  def draw_number
    @number_drawn = @remaining_balls.sample
    @remaining_balls.delete(@number_drawn)
    @number_drawn
  end

  def issue_cards(number_of_cards)
    @list_of_cards = Array.new
    number_of_cards.times do
      @list_of_cards << Bingocard.new(@card_size, @total_selection)
    end
    @list_of_cards
  end

  def simulate_round
    @bingo_histogram = {}
    issue_cards(@number_of_cards)
    @total_selection.times do |index|
      @bingo_histogram["Beurt #{index + 1}"] = 0
      @number = draw_number
      @list_of_cards.each do |bingo_card|
        bingo_card.cross_of_list(@number)
        if bingo_card.count_remaining.zero?
          bingo_histogram["Beurt #{index + 1}"] += 1
          # @list_of_cards.delete(bingo_card)
        end
      end

    end

  end
  
end

number_of_simulations = 1000
total_histo = {}
number_of_simulations.times do
  game = Bingogame.new(20, 60, 300)
  game.simulate_round
  total_histo = total_histo.merge(game.bingo_histogram) { |key, val1, val2| val1 + val2}
end

total_histo.each { |key, value| total_histo[key] = ((value.to_f/number_of_simulations)) } 
pp total_histo


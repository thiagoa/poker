require 'poker'

module Poker
  class CardsGroup
    extend Forwardable
    include Enumerable

    attr_reader :cards

    delegate length: :cards

    def initialize(cards)
      @cards = cards
    end

    def each
      cards.each { |card| yield card }
    end

    def ranks
      @ranks ||= cards.map(&:rank).sort.reverse
    end

    def rank_sequence?
      regular_sequence? || Poker.ace_high?(ranks)
    end

    def unique_suit?
      @cards.map(&:suit).uniq.length == 1
    end

    def ==(other)
      cards.sort == other.cards.sort
    end

    private

    def regular_sequence?
      (ranks.min..ranks.max).to_a.reverse == ranks
    end
  end
end

require 'poker/card_error'

module Poker
  class Card
    include Comparable

    SUITS = %i(spades hearts diamonds clubs)
    RANKS = 1..13

    attr_reader :rank, :suit

    def initialize(rank, suit)
      @rank = rank
      @suit = suit

      fail CardError, 'Invalid suit' unless SUITS.include?(suit)
      fail CardError, 'Invalid rank' unless RANKS.cover?(rank)
    end

    def ==(other)
      rank == other.rank && suit == other.suit
    end

    def <=>(other)
      rank <=> other.rank
    end
  end
end

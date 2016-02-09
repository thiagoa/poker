require 'poker/card'
require 'poker/card_error'

module Poker
  class CardsParser
    RANK_MAPPING = {
      'A' => 1,
      '2' => 2,
      '3' => 3,
      '4' => 4,
      '5' => 5,
      '6' => 6,
      '7' => 7,
      '8' => 8,
      '9' => 9,
      'T' => 10,
      'J' => 11,
      'Q' => 12,
      'K' => 13
    }

    SUIT_MAPPING = {
      'S' => :spades,
      'H' => :hearts,
      'D' => :diamonds,
      'C' => :clubs
    }

    def initialize(cards_abbreviations)
      @cards_abbreviations = cards_abbreviations
    end

    def call
      @cards_abbreviations.map { |card_abbr| create_card(card_abbr) }
    end

    private

    def create_card(card_abbr)
      Card.new(*fetch_parts(*card_abbr.chars))
    rescue KeyError
      raise CardError, "Could not parse invalid card: #{card_abbr}"
    end

    def fetch_parts(rank, suit)
      [RANK_MAPPING.fetch(rank), SUIT_MAPPING.fetch(suit)]
    end
  end
end

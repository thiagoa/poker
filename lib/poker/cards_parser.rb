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

    CARD_PATTERN = /^(?<rank>[1-9]|1[0-3]|[ATJQK])(?<suit>[SHDC])$/

    def initialize(cards_abbreviations)
      @cards_abbreviations = cards_abbreviations
    end

    def call
      @cards_abbreviations.map { |card_abbr| create_card(card_abbr) }
    end

    private

    def create_card(card_abbr)
      Card.new(*(extract_parts(card_abbr) || []).compact)
    rescue ArgumentError
      raise CardError, "Could not parse invalid card: #{card_abbr}"
    end

    def extract_parts(card_abbr)
      card_abbr.match(CARD_PATTERN) do |card|
        [RANK_MAPPING[card[:rank]], SUIT_MAPPING[card[:suit]]]
      end
    end
  end
end

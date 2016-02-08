require 'spec_helper'
require 'poker/card_error'
require 'poker/cards_parser'

module Poker
  RSpec.describe CardsParser do
    include Factory

    REGULAR_RANKS = 2..9
    SPECIAL_RANKS = {
      'T' => ['ten', 10],
      'J' => ['jacks', 11],
      'Q' => ['queen', 12],
      'K' => ['king', 13]
    }
    SUITS = {
      'S' => :spades,
      'H' => :hearts,
      'D' => :diamonds,
      'C' => :clubs
    }

    describe '#call' do
      it 'parses a collection with 1 card' do
        parser = CardsParser.new(['AC'])
        cards = stub_cards([1, :clubs])

        expect(parser.call).to eq cards
      end

      it 'parses a collection with 2 cards' do
        parser = CardsParser.new(['AC', '2C'])
        cards = stub_cards([1, :clubs], [2, :clubs])

        expect(parser.call).to eq cards
      end

      REGULAR_RANKS.each do |rank|
        it "parses cards with rank #{rank}" do
          parser = CardsParser.new(["#{rank}C"])
          cards = stub_cards([rank, :clubs])

          expect(parser.call).to eq cards
        end
      end

      SPECIAL_RANKS.each do |rank_symbol, (desc, rank)|
        it "parses the #{desc} rank" do
          parser = CardsParser.new(["#{rank_symbol}S"])
          cards = stub_cards([rank, :spades])

          expect(parser.call).to eq cards
        end
      end

      it 'fails when parsing an invalid rank' do
        expect { CardsParser.new(['1H']).call }.to(
          raise_error(CardError, /invalid card/)
        )
      end

      SUITS.each do |suit_symbol, suit|
        it "parses the #{suit} rank" do
          parser = CardsParser.new(["2#{suit_symbol}"])
          cards = stub_cards([2, suit])

          expect(parser.call).to eq cards
        end
      end

      it 'fails when parsing an invalid suit' do
        expect { CardsParser.new(['2J']).call }.to(
          raise_error(CardError, /invalid card/)
        )
      end
    end
  end
end

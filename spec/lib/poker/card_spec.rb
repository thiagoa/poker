require 'spec_helper'
require 'poker/card'

module Poker
  RSpec.describe Card do
    describe '.new' do
      it 'does not error out with valid ranks and suits' do
        expect {
          %i(spades hearts diamonds clubs).each do |suit|
            (1..13).each { |rank| Card.new(rank, suit) }
          end
        }.not_to raise_error
      end

      it 'errors out with invalid suits' do
        %i(diamond queen).each do |suit|
          expect { Card.new(1, suit) }.to raise_error(CardError)
        end
      end

      it 'errors out with invalid ranks' do
        [-1, 14].each do |rank|
          expect { Card.new(rank, :diamonds) }.to raise_error(CardError)
        end
      end
    end

    describe '#rank' do
      it 'has a rank' do
        card = Card.new(1, :spades)

        expect(card.rank).to eq 1
      end
    end

    describe '#suit' do
      it 'has a suit' do
        card = Card.new(1, :spades)

        expect(card.suit).to eq :spades
      end
    end

    describe '#==' do
      it 'succeeds comparing a card to an identical card' do
        expect(Card.new(1, :spades)).to eq Card.new(1, :spades)
      end

      it 'fails comparing a card to a different card' do
        expect(Card.new(1, :spades)).not_to eq Card.new(2, :hearts)
      end

      it 'fails comparing two cards with same rank and distinct suit' do
        expect(Card.new(1, :spades)).not_to eq Card.new(1, :hearts)
      end
    end

    describe '#<=>' do
      it 'compares cards by ranks' do
        expect(Card.new(2, :spades)).to be > Card.new(1, :hearts)
        expect(Card.new(2, :spades)).to be > Card.new(1, :spades)
        expect(Card.new(3, :spades)).to be < Card.new(4, :spades)
      end
    end
  end
end

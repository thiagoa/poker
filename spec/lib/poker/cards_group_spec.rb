require 'spec_helper'
require 'poker/cards_group'

module Poker
  RSpec.describe CardsGroup do
    include Factory

    describe '#length' do
      it 'has a length' do
        ranks = build_cards_group('AH 4D 7S 9C').ranks

        expect(ranks.length).to eq 4
      end
    end

    describe '#ranks' do
      it "extracts all card's ranks" do
        ranks = build_cards_group('AH 4D 7S 9C').ranks

        expect(ranks).to include(1, 4, 7, 9)
      end

      it 'extracts ranks ordered desc' do
        ranks = build_cards_group('AH 4D 7S 9C').ranks

        expect(ranks).to eq [9, 7, 4, 1]
      end
    end

    describe '#rank_sequence?' do
      it 'lowest sequence is a rank sequence' do
        group = build_cards_group('AH 2D 3H 4S 5C')

        expect(group).to be_rank_sequence
      end

      it 'is a rank sequence with out of order sequence' do
        group = build_cards_group('4H 2D 5H AS 3C')

        expect(group).to be_rank_sequence
      end

      it 'mid sequence is a rank sequence' do
        group = build_cards_group('5H 6D 7H 8S 9C')

        expect(group).to be_rank_sequence
      end

      it 'ace high is the highest sequence' do
        group = build_cards_group('TH JH QH KH AH')

        expect(group).to be_rank_sequence
      end

      it 'is not a rank sequence when not a number sequence' do
        group = build_cards_group('5S 6S 7S 8S TS')

        expect(group).not_to be_rank_sequence
      end

      it 'returns false when sequence overlaps beginning from the end' do
        groups = [
          build_cards_group('JH QH KH AH 2H'),
          build_cards_group('QH KH AH 2H 3H'),
          build_cards_group('KH AH 2H 3H 4H')
        ]

        expect(groups.any? { |g| g.rank_sequence? }).to be false
      end
    end

    describe '#unique_suit?' do
      it 'is unique when there is only one suit' do
        group = build_cards_group('AH 4H 7H 9H')

        expect(group).to be_unique_suit
      end

      it 'is not unique when there is more than one suit' do
        group = build_cards_group('AH 4S 7H 9H')

        expect(group).not_to be_unique_suit
      end
    end

    describe '#==' do
      it 'is equal when has the same cards' do
        expect(build_cards_group('AH 2H')).to eq build_cards_group('AH 2H')
      end

      it 'is equal when same cards are out of order' do
        expect(build_cards_group('2H AH')).to eq build_cards_group('AH 2H')
      end

      it 'is not equal when cards are different' do
        expect(build_cards_group('AH 2H')).not_to eq build_cards_group('AH 2S')
      end
    end
  end
end

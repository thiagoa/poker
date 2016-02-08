require 'spec_helper'
require 'poker/cards_group'
require 'poker/hand_comparator'
require 'poker/hand'

module Poker
  RSpec.describe Hand do
    include Factory

    describe '.new' do
      it 'fails if the hand does not have 5 cards' do
        expect {
          Hand.new(:foo, grouper_result_double(ranks: [1, 2, 3, 4]))
        }.to raise_error(HandError)
      end
    end

    describe '#ranks' do
      it "returns the hand's ranks" do
        first_group = grouper_result_double(ranks: [2, 2, 2])
        second_group = grouper_result_double(ranks: [3, 3])

        hand = Hand.new(:foo, [first_group, second_group])

        expect(hand.ranks).to eq([2, 2, 2, 3, 3])
      end
    end

    describe '#type' do
      it "returns the hand's type" do
        hand = Hand.new(:foo, grouper_result_double)

        expect(hand.type).to eq :foo
      end
    end

    describe '#ace_high?' do
      it 'returns true when sequence is an ace high' do
        hand = Hand.new(:foo, grouper_result_double(ranks: [10, 11, 12, 13, 1]))

        expect(hand).to be_ace_high
      end

      it 'returns false when sequence is not an ace high' do
        hand = Hand.new(:foo, grouper_result_double(ranks: [9, 10, 11, 12, 13]))

        expect(hand).not_to be_ace_high
      end
    end

    describe '#<=>' do
      it 'returns the results of HandComparator' do
        hand_1 = Hand.new(:foo, grouper_result_double)
        hand_2 = Hand.new(:bar, grouper_result_double)

        double.tap do |result|
          stub_hand_comparator(hand_1, hand_2, returns: result)

          expect(hand_1.<=>(hand_2)).to eq result
        end
      end

      it 'includes the Comparable module' do
        expect(Hand.new(:foo, grouper_result_double)).to be_a(Comparable)
      end
    end
  end
end

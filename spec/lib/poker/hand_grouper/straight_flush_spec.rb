require 'spec_helper'
require 'poker/hand_grouper/straight_flush'

module Poker
  module HandGrouper
    RSpec.describe StraightFlush do
      include Factory

      it 'returns empty collection when not a sequence of ranks' do
        grouper = StraightFlush.new(cards_group_double(rank_sequence: false))

        expect(grouper.call).to be_empty
      end

      it 'returns empty collection when not a unique suit' do
        grouper = StraightFlush.new(
          cards_group_double(rank_sequence: true, unique_suit: false)
        )

        expect(grouper.call).to be_empty
      end

      it 'groups cards when there is a sequence of ranks and unique suit' do
        cards_group = cards_group_double(rank_sequence: true, unique_suit: true)

        group = StraightFlush.new(cards_group).call

        expect(group.length).to eq 1
        expect(group).to include cards_group
      end
    end
  end
end

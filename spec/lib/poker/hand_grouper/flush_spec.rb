require 'spec_helper'
require 'poker/hand_grouper/flush'

module Poker
  module HandGrouper
    RSpec.describe Flush do
      include Factory

      it 'returns empty collection with a sequence of ranks' do
        grouper = Flush.new(cards_group_double(rank_sequence: true))

        expect(grouper.call).to be_empty
      end

      it 'returns empty collection when not a unique suit' do
        grouper = Flush.new(
          cards_group_double(rank_sequence: false, unique_suit: false)
        )

        expect(grouper.call).to be_empty
      end

      it 'groups cards when there is a unique suit and not sequence of ranks' do
        cards_group = cards_group_double(rank_sequence: false, unique_suit: true)

        group = Flush.new(cards_group).call

        expect(group.length).to eq 1
        expect(group).to include cards_group
      end
    end
  end
end

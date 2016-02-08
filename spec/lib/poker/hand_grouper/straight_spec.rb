require 'spec_helper'
require 'poker/hand_grouper/straight'

module Poker
  module HandGrouper
    RSpec.describe Straight do
      include Factory

      it 'returns empty collection when all cards have same suit' do
        grouper = Straight.new(cards_group_double(unique_suit: true))

        expect(grouper.call).to be_empty
      end

      it 'returns empty collection when not a rank sequence' do
        grouper = Straight.new(
          cards_group_double(rank_sequence: false, unique_suit: false)
        )

        expect(grouper.call).to be_empty
      end

      it 'groups cards when there is a sequence of ranks and not unique suit' do
        cards_group = cards_group_double(rank_sequence: true, unique_suit: false)

        group = Straight.new(cards_group).call

        expect(group.length).to eq 1
        expect(group).to include cards_group
      end
    end
  end
end

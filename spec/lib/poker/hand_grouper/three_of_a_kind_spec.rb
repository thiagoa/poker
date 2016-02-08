require 'spec_helper'
require 'poker/hand_grouper/three_of_a_kind'

module Poker
  module HandGrouper
    RSpec.describe ThreeOfAKind do
      include Factory

      it 'groups when three of a kind hand is present' do
        strategy = ThreeOfAKind.new(build_cards_group('2H 2S 2D 3C 4D'))

        expect(strategy.call).to have_group_order('2H 2S 2D', '3C 4D')
      end

      it 'does not group when three of a kind hand is not present' do
        strategy = ThreeOfAKind.new(build_cards_group('2H 2S 4D 3C 4D'))

        expect(strategy.call).to be_empty
      end
    end
  end
end

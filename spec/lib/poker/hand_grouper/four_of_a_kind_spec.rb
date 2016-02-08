require 'spec_helper'
require 'poker/hand_grouper/four_of_a_kind'

module Poker
  module HandGrouper
    RSpec.describe FourOfAKind do
      include Factory

      it 'groups when four of a kind hand is present' do
        strategy = FourOfAKind.new(build_cards_group('2H 2S 2D 2C 4D'))

        expect(strategy.call).to have_group_order('2H 2S 2D 2C', '4D')
      end

      it 'does not group when three of a kind hand is not present' do
        strategy = FourOfAKind.new(build_cards_group('2H 2S 4D 3C 4D'))

        expect(strategy.call).to be_empty
      end
    end
  end
end

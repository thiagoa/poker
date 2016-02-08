require 'spec_helper'
require 'poker/hand_grouper/one_pair'

module Poker
  module HandGrouper
    RSpec.describe OnePair do
      include Factory

      it 'groups when one pair hand is present' do
        strategy = OnePair.new(build_cards_group('2H 2S 3D 5C 4D'))

        expect(strategy.call).to have_group_order('2H 2S', '3D 5C 4D')
      end

      it 'does not group when two pair hand is not present' do
        strategy = OnePair.new(build_cards_group('2H 2S 2D 3C 5D'))

        expect(strategy.call).to be_empty
      end
    end
  end
end

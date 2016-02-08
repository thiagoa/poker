require 'spec_helper'
require 'poker/hand_grouper/two_pair'

module Poker
  module HandGrouper
    RSpec.describe TwoPair do
      include Factory

      it 'groups when two pair hand is present' do
        strategy = TwoPair.new(build_cards_group('2H 2S 3D 3C 4D'))

        expect(strategy.call).to have_group_order('3D 3C', '2H 2S', '4D')
      end

      it 'does not group when two pair hand is not present' do
        strategy = TwoPair.new(build_cards_group('2H 2S 4D 3C 5D'))

        expect(strategy.call).to be_empty
      end
    end
  end
end

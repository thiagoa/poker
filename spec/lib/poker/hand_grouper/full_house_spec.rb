require 'spec_helper'
require 'poker/hand_grouper/full_house'

module Poker
  module HandGrouper
    RSpec.describe FullHouse do
      include Factory

      it 'groups when full house hand is present' do
        strategy = FullHouse.new(build_cards_group('2H 2S 3D 3C 3H'))

        expect(strategy.call).to have_group_order('3D 3C 3H', '2H 2S')
      end

      it 'does not group when full house hand is not present' do
        strategy = FullHouse.new(build_cards_group('2H 2S 3D 3C 5H'))

        expect(strategy.call).to be_empty
      end
    end
  end
end

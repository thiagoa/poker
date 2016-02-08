require 'spec_helper'
require 'poker/hand_builder'

module Poker
  RSpec.describe HandBuilder do
    describe '#call' do
      it 'detects a straight flush' do
        expect('5C 6C 7C 8C 9C').to be_hand(:straight_flush)
        expect('AC TC JC QC KC').to be_hand(:straight_flush)
      end

      it 'detects a four of a kind' do
        expect('AC AH AD AS 8C').to be_hand(:four_of_a_kind)
        expect('AC AC AD AS 8C').to be_hand(:four_of_a_kind)
      end

      it 'detects a full house' do
        expect('KH KC KS TH TC').to be_hand(:full_house)
        expect('KH KC KH TH TH').to be_hand(:full_house)
      end

      it 'detects a flush' do
        expect('QC 8C 6C 4C 3C').to be_hand(:flush)
        expect('9H 8H 6H 5H 3H').to be_hand(:flush)
      end

      it 'detects a straight' do
        expect('2D 3C 4S 5D 6C').to be_hand(:straight)
        expect('AD TH JD QD KD').to be_hand(:straight)
      end

      it 'detects a three of a kind' do
        expect('AH AS AD KS QC').to be_hand(:three_of_a_kind)
        expect('KH KD KC JS QC').to be_hand(:three_of_a_kind)
      end

      it 'detects a two pair' do
        expect('AH AS KC KD QS').to be_hand(:two_pair)
        expect('KC KS QC QD 3S').to be_hand(:two_pair)
      end

      it 'detects a one pair' do
        expect('AH AS KH QS JD').to be_hand(:one_pair)
        expect('2H 2S 3S 4S 5S').to be_hand(:one_pair)
      end

      it 'detects a high card' do
        expect('AH KS QD JC 9S').to be_hand(:high_card)
        expect('AH KC QH JH 9H').to be_hand(:high_card)
      end
    end
  end
end

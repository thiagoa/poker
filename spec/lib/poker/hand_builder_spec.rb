require 'spec_helper'
require 'poker/hand_builder'

module Poker
  RSpec.describe HandBuilder do
    include Factory

    HAND_SAMPLES = [
      [:straight_flush,  ['5C 6C 7C 8C 9C', 'AC TC JC QC KC']],
      [:four_of_a_kind,  ['AC AH AD AS 8C', 'AC AC AD AS 8C']],
      [:full_house,      ['KH KC KS TH TC', 'KH KC KH TH TH']],
      [:flush,           ['QC 8C 6C 4C 3C', '9H 8H 6H 5H 3H']],
      [:straight,        ['2D 3C 4S 5D 6C', 'AD TH JD QD KD']],
      [:three_of_a_kind, ['AH AS AD KS QC', 'KH KD KC JS QC']],
      [:two_pair,        ['AH AS KC KD QS', 'KC KS QC QD 3S']],
      [:one_pair,        ['AH AS KH QS JD', '2H 2S 3S 4S 5S']],
      [:high_card,       ['AH KS QD JC 9S', 'AH KC QH JH 9H']]
    ]

    describe '#call' do
      HAND_SAMPLES.each.with_index(1) do |(hand_type, hand_samples), i|
        context "when the hand is a #{hand_type}" do
          it 'is detected' do
            hands = hand_samples.map do |string_hand|
              build_hand(string_hand).call.type
            end

            expect(hands).to all(be hand_type)
          end

          HAND_SAMPLES.drop(i).each do |lower_hand_type, lower_hand_samples|
            it "scores higher than #{lower_hand_type}" do
              higher_hand = build_hand(hand_samples.first).call
              lower_hand = build_hand(lower_hand_samples.first).call

              expect(higher_hand).to be > lower_hand
            end
          end
        end
      end
    end
  end
end

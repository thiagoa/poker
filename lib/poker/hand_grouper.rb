require 'pathname'

Pathname(__dir__).join('hand_grouper').children.each do |file|
  require file.to_s
end

module Poker
  module HandGrouper
    def traditional_high_poker
      [
        HighCard,
        OnePair,
        TwoPair,
        ThreeOfAKind,
        Straight,
        Flush,
        FullHouse,
        FourOfAKind,
        StraightFlush
      ]
    end

    class Collection
      def initialize(hand_groupers_ordered_by_score)
        @hand_groupers = hand_groupers_ordered_by_score
      end

      def all_with_score
        @all ||= @hand_groupers.map.with_index.to_a.reverse
      end
    end
  end
end

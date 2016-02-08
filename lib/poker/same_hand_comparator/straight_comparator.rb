module Poker
  module SameHandComparator
    class StraightComparator
      def self.applies_to?(hand_type)
        %i(straight straight_flush).include?(hand_type)
      end

      def initialize(hand_comparator)
        @left_hand = hand_comparator.left_hand
        @right_hand = hand_comparator.right_hand
      end

      def call
        return solve_with_ace_high_rule if any_ace_high?

        @left_hand.ranks.max <=> @right_hand.ranks.max
      end

      def solve_with_ace_high_rule
        case [@left_hand.ace_high?, @right_hand.ace_high?]
        when [true, true]
          0
        when [true, false]
          1
        else
          -1
        end
      end

      def any_ace_high?
        @left_hand.ace_high? || @right_hand.ace_high?
      end
    end
  end
end

module Poker
  module SameHandComparator
    class DefaultComparator
      TIE = 0

      def self.applies_to?(hand_type)
        !%i(straight straight_flush).include?(hand_type)
      end

      def initialize(hand_comparator)
        @left_hand = hand_comparator.left_hand
        @right_hand = hand_comparator.right_hand
      end

      def call
        compare_ranks_from_left_to_right || TIE
      end

      private

      def compare_ranks_from_left_to_right
        @left_hand.ranks.zip(@right_hand.ranks) do |rank_1, rank_2|
          return rank_1 <=> rank_2 if rank_1 != rank_2
        end
      end
    end
  end
end

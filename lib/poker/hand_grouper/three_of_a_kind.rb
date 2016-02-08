require 'poker/hand_grouper/group_by_rank_and_side_cards'

module Poker
  module HandGrouper
    class ThreeOfAKind < GroupByRankAndSideCards
      def group_lengths
        [3]
      end
    end
  end
end

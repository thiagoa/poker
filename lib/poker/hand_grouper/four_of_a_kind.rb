require 'poker/hand_grouper/group_by_rank_and_side_cards'

module Poker
  module HandGrouper
    class FourOfAKind < GroupByRankAndSideCards
      def group_lengths
        [4]
      end
    end
  end
end

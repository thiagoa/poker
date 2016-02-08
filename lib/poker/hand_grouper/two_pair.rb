require 'poker/hand_grouper/group_by_rank_and_side_cards'

module Poker
  module HandGrouper
    class TwoPair < GroupByRankAndSideCards
      def group_lengths
        [2, 2]
      end
    end
  end
end

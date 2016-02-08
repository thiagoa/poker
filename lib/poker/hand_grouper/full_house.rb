require 'poker/hand_grouper/group_by_rank_and_side_cards'

module Poker
  module HandGrouper
    class FullHouse < GroupByRankAndSideCards
      def group_lengths
        [2, 3]
      end
    end
  end
end

require 'poker/hand_grouper/base'
require 'poker/rank_group_extractor'

module Poker
  module HandGrouper
    class GroupByRankAndSideCards < Base
      def initialize(cards, rank_group_extractor = RankGroupExtractor)
        @rank_group_extractor = rank_group_extractor.new(cards, group_lengths)
      end

      def group_lengths
        fail NotImplementedError
      end

      def call
        @rank_group_extractor.call
      end
    end
  end
end

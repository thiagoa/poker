require 'poker/hand_grouper/base'

module Poker
  module HandGrouper
    class StraightFlush < Base
      def call
        return [] if not straight_flush?

        [@cards]
      end

      private

      def straight_flush?
        @cards.rank_sequence? && @cards.unique_suit?
      end
    end
  end
end

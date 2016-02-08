require 'poker/hand_grouper/base'

module Poker
  module HandGrouper
    class Flush < Base
      def call
        return [] if not flush?

        [@cards]
      end

      private

      def flush?
        !@cards.rank_sequence? && @cards.unique_suit?
      end
    end
  end
end

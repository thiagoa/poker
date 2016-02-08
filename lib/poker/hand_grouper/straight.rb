require 'poker/hand_grouper/base'

module Poker
  module HandGrouper
    class Straight < Base
      def call
        return [] if not straight?

        [@cards]
      end

      private

      def straight?
        !@cards.unique_suit? && @cards.rank_sequence?
      end
    end
  end
end

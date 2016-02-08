module Poker
  module HandGrouper
    class HighCard < Base
      def call
        [@cards]
      end
    end
  end
end

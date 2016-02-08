module Poker
  module HandGrouper
    class Base
      def self.type
        name.split('::').last.split(/(?=[A-Z])/).join('_').downcase.to_sym
      end

      def initialize(cards)
        @cards = cards
      end

      def call
        fail NotImplementedError
      end
    end
  end
end

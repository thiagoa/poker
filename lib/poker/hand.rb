require 'poker'
require 'poker/hand_comparator'
require 'poker/hand_error'

module Poker
  class Hand
    include Comparable

    NUMBER_OF_CARDS = 5

    attr_reader :type

    def initialize(type, card_groups)
      @type = type
      @card_groups = card_groups

      fail HandError unless ranks.length == NUMBER_OF_CARDS
    end

    def <=>(other)
      HandComparator.new(self, other).call
    end

    def ranks
      @card_groups.flat_map(&:ranks)
    end

    def ace_high?
      Poker.ace_high?(ranks)
    end
  end
end

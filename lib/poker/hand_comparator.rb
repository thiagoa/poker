require 'poker/same_hand_comparator'

module Poker
  class HandComparator
    attr_reader :left_hand, :right_hand

    def initialize(left_hand, right_hand)
      @left_hand = left_hand
      @right_hand = right_hand
    end

    def call
      return compare_same_hand if same_hand_type?

      @left_hand.score <=> @right_hand.score
    end

    private

    def compare_same_hand
      SameHandComparator.find(@left_hand.type).new(self).call
    end

    def same_hand_type?
      @left_hand.type == @right_hand.type
    end
  end
end

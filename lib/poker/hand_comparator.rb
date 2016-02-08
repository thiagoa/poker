require 'poker/same_hand_comparator'

module Poker
  class HandComparator
    SCORES = %i(
      high_card
      one_pair
      two_pair
      three_of_a_kind
      straight
      flush
      full_house
      four_of_a_kind
      straight_flush
    )

    attr_reader :left_hand, :right_hand

    def initialize(left_hand, right_hand)
      @left_hand = left_hand
      @right_hand = right_hand
    end

    def call
      return compare_same_hand if same_hand_type?

      score(@left_hand) <=> score(@right_hand)
    end

    private

    def score(hand)
      SCORES.index(hand.type)
    end

    def compare_same_hand
      SameHandComparator.find(@left_hand.type).new(self).call
    end

    def same_hand_type?
      @left_hand.type == @right_hand.type
    end
  end
end

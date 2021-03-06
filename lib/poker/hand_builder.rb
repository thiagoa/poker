require 'poker/cards_group'
require 'poker/hand'
require 'poker/hand_grouper'

module Poker
  class HandBuilder
    def initialize(cards, hand_groupers)
      @cards_group = CardsGroup.new(cards)
      @hand_groupers = hand_groupers
    end

    def call
      grouper_class, score = detect_hand
      Hand.new(grouper_class.type, score, @grouped_hand)
    end

    private

    def detect_hand
      @hand_groupers.all_with_score.find do |grouper_class, _|
        group_with(grouper_class).any?
      end
    end

    def group_with(grouper_class)
      @grouped_hand = grouper_class.new(@cards_group).call
    end
  end
end

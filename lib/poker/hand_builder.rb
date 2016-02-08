require 'poker/cards_group'
require 'poker/hand'
require 'poker/hand_grouper'

module Poker
  class HandBuilder
    def initialize(cards)
      @cards_group = CardsGroup.new(cards)
    end

    def call
      Hand.new(detect_hand.type, @grouped_hand)
    end

    private

    def detect_hand
      HandGrouper.all.find { |grouper_class| group_with(grouper_class).any? }
    end

    def group_with(grouper_class)
      @grouped_hand = grouper_class.new(@cards_group).call
    end
  end
end

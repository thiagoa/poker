require 'poker/cards_group'
require 'poker/cards_parser'
require 'poker/hand_builder'
require 'poker/hand_comparator'
require 'poker/rank_group_extractor'
require 'poker/hand'

module Poker
  module Factory
    def build_cards_group(cards)
      CardsGroup.new(build_cards(cards))
    end

    def build_cards(cards)
      cards = cards.split(' ') if cards.respond_to?(:split)
      CardsParser.new(cards).call
    end

    def build_hand(cards)
      HandBuilder.new(build_cards(cards))
    end

    def build_hand_comparator(left_hand, right_hand)
      HandComparator.new(left_hand, right_hand)
    end

    def build_rank_group_extractor(cards, lengths)
      grouper = RankGroupExtractor.new(build_cards(cards), lengths)
    end

    def human_readable_card_groups(card_groups)
      actual.map do |group|
        group.map { |card| card.rank.to_s + card.suit[0].upcase }
      end
    end

    def cards_group_double(rank_sequence: false, unique_suit: false)
      instance_double('CardsGroup').tap do |cards_group|
        allow(cards_group).to receive(:rank_sequence?).and_return(rank_sequence)
        allow(cards_group).to receive(:unique_suit?).and_return(unique_suit)
      end
    end

    def stub_hand_comparator(hand_1, hand_2, returns:)
      hand_comparator = instance_double('HandComparator')
      allow(hand_comparator).to receive(:call).and_return(returns)

      allow(HandComparator).to receive(:new)
        .with(hand_1, hand_2)
        .and_return(hand_comparator)
    end

    def grouper_result_double(ranks: [1] * 5)
      double(flat_map: ranks, ranks: ranks)
    end

    def stub_cards(*cards)
      cards.each.with_object([]) do |card, collection|
        double('card').tap do |card_double|
          allow(Card).to receive(:new)
            .with(*card)
            .and_return(card_double)

          collection << card_double
        end
      end
    end

    def hand_double(type, ace_high: nil, ranks: nil)
      instance_double('Hand').tap do |hand|
        expect(hand).to receive(:type).and_return(type).at_least(:once)

        stub_message(hand, :ace_high?, ace_high) unless ace_high.nil?
        stub_message(hand, :ranks, ranks) if ranks
      end
    end

    def stub_message(dbl, message, value)
      expect(dbl).to receive(message).and_return(value).at_least(:once)
    end
  end
end

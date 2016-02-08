require 'poker/cards_group'

module Poker
  GroupError = Class.new(StandardError)

  class RankGroupExtractor
    def initialize(cards, group_lengths)
      fail GroupError, "Can't extract length 1" if group_lengths.include?(1)

      @cards = cards
      @group_lengths = group_lengths
    end

    def call
      return [] if rank_groups.empty?

      @groups ||= rank_groups + side_cards_group
    end

    private

    def rank_groups
      @rank_groups ||= group_extractor.strict(@group_lengths)
        .map { |group| CardsGroup.new(group) }
        .sort { |a, b| compare_group(a, b) }
        .reverse
    end

    def compare_group(a, b)
      [a.length, a.ranks.max] <=> [b.length, b.ranks.max]
    end

    def side_cards_group
      return [] if groups_with_1.empty?

      [CardsGroup.new(groups_with_1.inject(:+))]
    end

    def groups_with_1
      @groups_with_1 ||= group_extractor.non_strict([1])
    end

    def group_extractor
      @group_extractor ||= GroupExtractor.new(@cards)
    end

    class GroupExtractor
      def initialize(cards)
        @cards = cards
      end

      def non_strict(lengths)
        extract_groups(lengths)
      end

      def strict(lengths)
        non_strict(lengths).tap do |groups|
          return [] unless all_available?(groups, lengths)
        end
      end

      private

      def all_available?(groups, lengths)
        groups.map(&:length).sort == lengths.sort
      end

      def extract_groups(lengths)
        all_groups.select { |group| lengths.include?(group.length) }
      end

      def all_groups
        @all_groups ||= @cards.group_by(&:rank).values
      end
    end
  end
end

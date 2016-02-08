require 'pathname'

Pathname(__dir__).join('same_hand_comparator').children.each do |file|
  require file.to_s
end

module Poker
  module SameHandComparator
    def self.all
      @all ||= [StraightComparator, DefaultComparator]
    end

    def self.find(hand_type)
      all.find { |comparator| comparator.applies_to?(hand_type) }
    end
  end
end

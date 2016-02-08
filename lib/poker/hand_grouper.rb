require 'pathname'

Pathname(__dir__).join('hand_grouper').children.each do |file|
  require file.to_s
end

module Poker
  module HandGrouper
    def self.all
      @all ||= [
        StraightFlush,
        FourOfAKind,
        FullHouse,
        Flush,
        Straight,
        ThreeOfAKind,
        TwoPair,
        OnePair,
        HighCard
      ]
    end
  end
end

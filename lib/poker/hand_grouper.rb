require 'pathname'

Pathname(__dir__).join('hand_grouper').children.each do |file|
  require file.to_s
end

module Poker
  module HandGrouper
    ALL_BY_SCORE ||= [
      HighCard,
      OnePair,
      TwoPair,
      ThreeOfAKind,
      Straight,
      Flush,
      FullHouse,
      FourOfAKind,
      StraightFlush
    ]
    private_constant :ALL_BY_SCORE

    def self.all_with_score
      ALL_BY_SCORE.map.with_index.to_a.reverse
    end
  end
end

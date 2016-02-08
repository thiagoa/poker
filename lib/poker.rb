module Poker
  ACE_HIGH = [1, 10, 11, 12, 13]

  def self.ace_high?(ranks)
    ranks.sort == ACE_HIGH
  end
end

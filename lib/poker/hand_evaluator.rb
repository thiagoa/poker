class HandEvaluator
  include Poker::Factory

  def return_stronger_hand(raw_left_hand, raw_right_hand)
    left_hand, right_hand = build_hands(raw_left_hand, raw_right_hand)

    if left_hand > right_hand
      raw_left_hand
    else
      raw_right_hand
    end
  end

  private

  def build_hands(*raw_hands)
    raw_hands.map { |raw_hand| build_hand(raw_hand).call }
  end
end

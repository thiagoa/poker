RSpec::Matchers.define :have_groups do |*expected|
  include Poker::Factory

  match do |actual|
    expected.all? { |e| actual.include?(build_cards_group(e)) } &&
      expected.length == actual.length
  end
  
  failure_message do |actual|
    actual_groups = human_readable_card_groups(actual)
    "expected that #{actual_groups} would have exactly #{expected} groups"
  end
end

RSpec::Matchers.define :have_group_order do |*expected|
  include Poker::Factory

  match do |actual|
    expected.map { |e| build_cards_group(e) } == actual
  end
  
  failure_message do |actual|
    actual_groups = human_readable_card_groups(actual)
    "expected that #{actual_groups} would have group order of #{expected}"
  end
end

RSpec::Matchers.define :be_hand do |hand_type|
  include Poker::Factory

  match do |string_hand|
    build_hand(string_hand).call.type == hand_type
  end

  failure_message do |expected_hand|
    actual_hand = build_hand(expected_hand).call.type
    "expected #{actual} hand to be of type #{hand_type}, but was #{actual_hand}"
  end
end

RSpec::Matchers.define :be_higher_than do |lower_hand|
  include Poker::Factory

  match do |higher_hand|
    build_hand_comparator(higher_hand, lower_hand).call == 1 &&
      build_hand_comparator(lower_hand, higher_hand).call == -1
  end

  failure_message do |higher_hand|
    "expected #{higher_hand} to be higher than #{lower_hand}, but was not"
  end
end

RSpec::Matchers.define :tie_with do |hand_2|
  include Poker::Factory

  match do |hand_1|
    build_hand_comparator(hand_1, hand_2).call == 0 &&
      build_hand_comparator(hand_2, hand_1).call == 0
  end

  failure_message do |hand_1|
    "expected #{hand_1} to tie with #{hand_2}, but did not"
  end
end

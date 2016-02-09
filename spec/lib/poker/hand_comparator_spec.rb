require 'spec_helper'
require 'poker/hand_comparator'

module Poker
  RSpec.describe HandComparator do
    include Factory

    describe '#call' do
      context 'when comparing different hand types' do
        it 'wins the hand with highest score' do
          winner = hand_double(:foo, score: 1)
          loser = hand_double(:bar, score: 0)

          expect(winner).to be_higher_than(loser)
        end

        it 'ties when hands have same score' do
          winner = hand_double(:foo, score: 1)
          loser = hand_double(:bar, score: 1)

          expect(winner).to tie_with(loser)
        end
      end

      context 'when comparing equal hand types' do
        %i(straight_flush straight).each do |type|
          context "with a #{type}" do
            context 'when one or two hands are ace highs' do
              it 'ties when both are ace high' do
                hand_1 = hand_double(type, ace_high: true)
                hand_2 = hand_double(type, ace_high: true)

                expect(hand_1).to tie_with(hand_2)
              end

              it "first hand wins when it's the only ace high" do
                winner = hand_double(type, ace_high: true)
                loser = hand_double(type, ace_high: false)

                expect(winner).to be_higher_than(loser)
              end

              it "second hand wins when it's the only ace high" do
                winner = hand_double(type, ace_high: true)
                loser = hand_double(type, ace_high: false)

                expect(winner).to be_higher_than(loser)
              end
            end

            context 'when no hand is ace high' do
              it 'ties when both hands have exactly the same ranks' do
                hand_1 = hand_double(type, ace_high: false, ranks: [10, 9, 8, 7, 6])
                hand_2 = hand_double(type, ace_high: false, ranks: [10, 9, 8, 7, 6])

                expect(hand_1).to tie_with(hand_2)
              end

              it 'wins the one with the highest rank on the left' do
                winner = hand_double(type, ace_high: false, ranks: [10, 9, 8, 7, 6])
                loser = hand_double(type, ace_high: false, ranks: [9, 8, 7, 6, 5])

                expect(winner).to be_higher_than(loser)
              end
            end
          end
        end

        context 'when both hands are not straight or straight flush' do
          it 'wins the one which has highest 1st rank by the left' do
            winner = hand_double(:foo, ranks: [10, 9, 8, 7, 6])
            loser = hand_double(:foo, ranks: [9, 8, 7, 6, 5])

            expect(winner).to be_higher_than(loser)
          end

          context 'when there is a tie on 1st rank' do
            it 'wins the one which has highest 2th rank by the left' do
              winner = hand_double(:foo, ranks: [10, 9, 8, 7, 6])
              loser = hand_double(:foo, ranks: [10, 8, 7, 6, 5])

              expect(winner).to be_higher_than(loser)
            end
          end

          context 'when there is a tie on 2th rank' do
            it 'wins the one which has highest 3th rank by the left' do
              winner = hand_double(:foo, ranks: [10, 9, 8, 7, 6])
              loser = hand_double(:foo, ranks: [10, 9, 7, 6, 5])

              expect(winner).to be_higher_than(loser)
            end
          end

          context 'when there is a tie on 3th rank' do
            it 'wins the one which has highest 4th rank by the left' do
              winner = hand_double(:foo, ranks: [10, 9, 8, 7, 6])
              loser = hand_double(:foo, ranks: [10, 9, 8, 6, 5])

              expect(winner).to be_higher_than(loser)
            end
          end

          context 'when there is a tie on 4th rank' do
            it 'wins the one which has highest 5th rank by the left' do
              winner = hand_double(:foo, ranks: [10, 9, 8, 7, 6])
              loser = hand_double(:foo, ranks: [10, 9, 8, 7, 5])

              expect(winner).to be_higher_than(loser)
            end
          end

          context 'when there is a tie on 5th rank' do
            it 'ties' do
              winner = hand_double(:foo, ranks: [10, 9, 8, 7, 6])
              loser = hand_double(:foo, ranks: [10, 9, 8, 7, 6])

              expect(winner).to tie_with(loser)
            end
          end
        end
      end
    end
  end
end

require 'spec_helper'
require 'poker/rank_group_extractor'

module Poker
  module HandGrouper
    RSpec.describe RankGroupExtractor do
      include Factory

      describe '#call' do
        it 'does not permit extracting groups of length 1' do
          expect { build_rank_group_extractor('AH', [1]) }.to(
            raise_error(GroupError, /Can't extract/)
          )

          expect { build_rank_group_extractor('AH TS', [1, 1]) }.to(
            raise_error(GroupError, /Can't extract/)
          )
        end

        describe 'when extracting 2 groups of length 2' do
          it 'only extracts when both groups are present' do
            grouper = build_rank_group_extractor('AH AS 2C 2S', [2, 2])

            expect(grouper.call).to have_groups('AH AS', '2C 2S')
          end

          it 'fails when there is only 1 group of length 2' do
            grouper = build_rank_group_extractor('AH AS', [2, 2])

            expect(grouper.call).to be_empty
          end
        end

        describe 'when extracting 1 group of length 2 + another of length 3' do
          it 'only extracts when both groups are present' do
            grouper = build_rank_group_extractor('AH AS AD 2C 2S', [2, 3])

            expect(grouper.call).to have_groups('AH AS AD', '2C 2S')
          end

          it 'fails when there is only one group of length 3' do
            grouper = build_rank_group_extractor('AH AS AD', [2, 3])

            expect(grouper.call).to be_empty
          end

          it 'fails when there is only one group of length 2' do
            grouper = build_rank_group_extractor('2C 2S', [2, 3])

            expect(grouper.call).to be_empty
          end
        end

        context 'when extracting 1 group of length 2' do
          it 'only extracts when 1 group present' do
            grouper = build_rank_group_extractor('2S 2C', [2])

            expect(grouper.call).to have_groups('2S 2C')
          end

          it 'does not extract when 2 groups of length 2 are present' do
            grouper = build_rank_group_extractor('2S 2C AH AC', [2])

            expect(grouper.call).to be_empty
          end

          context 'when there are additional groups of length 1' do
            it 'joins the groups on one side cards group' do
              grouper = build_rank_group_extractor('2S 2C 8H 9S TD', [2])

              expect(grouper.call).to have_groups('2S 2C', '8H 9S TD')
            end
          end
        end

        describe 'card groups order' do
          it 'orders by group length desc' do
            grouper = build_rank_group_extractor('TD TH 8S 8C 8D', [2, 3])

            expect(grouper.call).to have_group_order('8S 8C 8D', 'TD TH')
          end

          it 'side cards are always last' do
            grouper = build_rank_group_extractor('TD AH QS 8C 8D', [2])

            expect(grouper.call).to have_group_order('8C 8D', 'TD AH QS')
          end

          context 'when there are two groups of same length' do
            it 'orders by highest rank desc' do
              grouper = build_rank_group_extractor('2C 2S AH AS', [2, 2])

              expect(grouper.call).to have_group_order('2C 2S', 'AH AS')
            end

            it 'side cards are always last' do
              grouper = build_rank_group_extractor('2C 2S AH AS TH', [2, 2])

              expect(grouper.call).to have_group_order('2C 2S', 'AH AS', 'TH')
            end
          end
        end
      end
    end
  end
end

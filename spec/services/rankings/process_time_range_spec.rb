require 'rails_helper'

describe Rankings::ProcessTimeRange do
  shared_context 'improper time range string' do
    let(:time_range_string) { 'super_long' }
  end

  shared_examples 'wrong time range error raised' do
    it 'raises an error' do
      expect { subject.time_range }.to raise_error('Wrong time range')
    end
  end

  subject { described_class.new(time_range_string) }

  describe '#time_range' do
    context 'when time range string is improper' do
      include_context 'improper time range string'

      include_examples 'wrong time range error raised'
    end

    context 'when time range params are valid' do
      let(:current_time) { Time.current }

      before do
        allow(Time).to receive(:current).and_return(current_time)
      end

      context 'when time range is "weekly"' do
        let(:time_range_string) { 'weekly' }
        let(:time_range) { 1.week.ago..current_time }

        it 'returns proper ruby time range' do
          expect(subject.time_range).to eq(time_range)
        end
      end

      context 'when time range is "bi-weekly"' do
        let(:time_range_string) { 'bi-weekly' }
        let(:time_range) { 2.weeks.ago..current_time }

        it 'returns proper ruby time range' do
          expect(subject.time_range).to eq(time_range)
        end
      end

      context 'when time range is "monthly"' do
        let(:time_range_string) { 'monthly' }
        let(:time_range) { 1.month.ago..current_time }

        it 'returns proper ruby time range' do
          expect(subject.time_range).to eq(time_range)
        end
      end

      context 'when time range is "yearly"' do
        let(:time_range_string) { 'yearly' }
        let(:time_range) { 1.year.ago..current_time }

        it 'returns proper ruby time range' do
          expect(subject.time_range).to eq(time_range)
        end
      end

      context 'when time range is "all"' do
        let(:time_range_string) { 'all' }
        context 'and there are no Kudos in database' do
          let(:time_range) { 1.week.ago..current_time }

          it 'returns one week time range' do
            expect(subject.time_range).to eq(time_range)
          end
        end

        context 'and there is alreade a saved Kudos' do
          let!(:first_kudos) { create(:prop, created_at: 13.months.ago) }
          let(:time_range) { first_kudos.created_at..current_time }

          it 'returns time range from first Kudos creation date untill now' do
            expect(subject.time_range).to eq(time_range)
          end
        end
      end
    end
  end

  describe '#time_interval' do
    context 'when time range string is improper' do
      include_context 'improper time range string'

      include_examples 'wrong time range error raised'
    end

    context 'when time range params are valid' do
      context 'when time range is "weekly"' do
        let(:time_range_string) { 'weekly' }
        let(:time_interval) { 'day' }

        it 'returns proper time interval string' do
          expect(subject.time_interval).to eq(time_interval)
        end
      end

      context 'when time range is "bi-weekly"' do
        let(:time_range_string) { 'bi-weekly' }
        let(:time_interval) { 'day' }

        it 'returns proper time interval string' do
          expect(subject.time_interval).to eq(time_interval)
        end
      end

      context 'when time range is "monthly"' do
        let(:time_range_string) { 'monthly' }
        let(:time_interval) { 'day' }

        it 'returns proper time interval string' do
          expect(subject.time_interval).to eq(time_interval)
        end
      end

      context 'when time range is "yearly"' do
        let(:time_range_string) { 'yearly' }
        let(:time_interval) { 'month' }

        it 'returns proper time interval string' do
          expect(subject.time_interval).to eq(time_interval)
        end
      end

      context 'when time range is "all"' do
        let(:time_range_string) { 'all' }

        context 'and there are no Kudos in database' do
          let(:time_interval) { 'day' }

          it 'returns "day" time interval' do
            expect(subject.time_interval).to eq(time_interval)
          end
        end

        context 'and there is alreade a saved Kudos' do
          context 'which is younger than two months' do
            let!(:first_kudos) { create(:prop, created_at: 1.month.ago) }
            let(:time_interval) { 'day' }

            it 'returns "day" time interval' do
              expect(subject.time_interval).to eq(time_interval)
            end
          end

          context 'which is older than two months' do
            let!(:first_kudos) { create(:prop, created_at: 11.months.ago) }
            let(:time_interval) { 'month' }

            it 'returns "month" time interval' do
              expect(subject.time_interval).to eq(time_interval)
            end
          end
        end
      end
    end
  end
end

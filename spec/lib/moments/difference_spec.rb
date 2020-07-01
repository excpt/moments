# frozen_string_literal: true

describe Moments::Difference do
  let(:from) { Time.new 2007, 1, 1 }
  let(:to)   { Time.new 2012, 1, 1 }

  describe '#new' do
    context 'without arguments' do
      it { expect { Moments::Difference.new }.to raise_error(ArgumentError) }
    end
  end

  context '#to_hash' do
    subject { Moments::Difference.new(from, to).to_hash }

    describe 'order of keys' do
      subject { super().keys }

      it { is_expected.to eq %i[years months days hours minutes seconds] }
    end

    context 'with equal dates' do
      let(:to) { from }

      let(:expected_result) do
        {
          years: 0,
          months: 0,
          days: 0,
          hours: 0,
          minutes: 0,
          seconds: 0
        }
      end

      it { is_expected.to eq expected_result }
    end

    describe 'seconds' do
      let(:expected_result) do
        {
          years: 0,
          months: 0,
          days: 0,
          hours: 0,
          minutes: 0,
          seconds: 1
        }
      end

      context 'when future' do
        context 'when the same day' do
          let(:from) { Time.new 2013, 1, 1, 0, 0, 0 }
          let(:to)   { Time.new 2013, 1, 1, 0, 0, 1 }

          it { is_expected.to eq expected_result }
        end

        context 'when different days' do
          let(:from) { Time.new 2013, 1, 31, 23, 59, 59 }
          let(:to)   { Time.new 2013, 2, 1, 0, 0, 0 }

          it { is_expected.to eq expected_result }
        end
      end

      context 'when past' do
        context 'when the same day' do
          let(:from) { Time.new 2013, 1, 1, 0, 0, 1 }
          let(:to)   { Time.new 2013, 1, 1, 0, 0, 0 }

          it { is_expected.to eq expected_result }
        end

        context 'when different days' do
          let(:from) { Time.new 2013, 2, 1, 0, 0, 0 }
          let(:to)   { Time.new 2013, 1, 31, 23, 59, 59 }

          it { is_expected.to eq expected_result }
        end
      end
    end

    describe 'minutes' do
      let(:expected_result) do
        {
          years: 0,
          months: 0,
          days: 0,
          hours: 0,
          minutes: 2,
          seconds: 1
        }
      end

      context 'when future' do
        context 'when the same day' do
          let(:from) { Time.new 2013, 1, 1, 0, 0, 0 }
          let(:to)   { Time.new 2013, 1, 1, 0, 2, 1 }

          it { is_expected.to eq expected_result }
        end

        context 'when different days' do
          let(:from) { Time.new 2013, 1, 31, 23, 59, 59 }
          let(:to)   { Time.new 2013, 2, 1, 0, 2, 0 }

          it { is_expected.to eq expected_result }
        end
      end

      context 'when past' do
        context 'when the same day' do
          let(:from) { Time.new 2013, 1, 1, 0, 2, 1 }
          let(:to)   { Time.new 2013, 1, 1, 0, 0, 0 }

          it { is_expected.to eq expected_result }
        end

        context 'when different days' do
          let(:from) { Time.new 2013, 2, 1, 0, 2, 0 }
          let(:to)   { Time.new 2013, 1, 31, 23, 59, 59 }

          it { is_expected.to eq expected_result }
        end
      end
    end

    describe 'hours' do
      let(:expected_result) do
        {
          years: 0,
          months: 0,
          days: 0,
          hours: 3,
          minutes: 2,
          seconds: 1
        }
      end

      context 'when future' do
        context 'when the same day' do
          let(:from) { Time.new 2013, 1, 1, 0, 0, 0 }
          let(:to)   { Time.new 2013, 1, 1, 3, 2, 1 }

          it { is_expected.to eq expected_result }
        end

        context 'when different days' do
          let(:from) { Time.new 2013, 1, 31, 23, 59, 59 }
          let(:to)   { Time.new 2013, 2, 1, 3, 2, 0 }

          it { is_expected.to eq expected_result }
        end
      end

      context 'when past' do
        context 'when the same day' do
          let(:from) { Time.new 2013, 1, 1, 3, 2, 1 }
          let(:to)   { Time.new 2013, 1, 1, 0, 0, 0 }

          it { is_expected.to eq expected_result }
        end

        context 'when different days' do
          let(:from) { Time.new 2013, 2, 1, 3, 2, 0 }
          let(:to)   { Time.new 2013, 1, 31, 23, 59, 59 }

          it { is_expected.to eq expected_result }
        end
      end
    end

    describe 'days' do
      let(:expected_result) do
        {
          years: 0,
          months: 0,
          days: 4,
          hours: 3,
          minutes: 2,
          seconds: 1
        }
      end

      context 'when future' do
        context 'when the same day' do
          let(:from) { Time.new 2013, 1, 1, 0, 0, 0 }
          let(:to)   { Time.new 2013, 1, 5, 3, 2, 1 }

          it { is_expected.to eq expected_result }
        end

        context 'when different days' do
          let(:from) { Time.new 2013, 1, 31, 23, 59, 59 }
          let(:to)   { Time.new 2013, 2, 5, 3, 2, 0 }

          it { is_expected.to eq expected_result }
        end
      end

      context 'when past' do
        context 'when the same day' do
          let(:from) { Time.new 2013, 1, 5, 3, 2, 1 }
          let(:to)   { Time.new 2013, 1, 1, 0, 0, 0 }

          it { is_expected.to eq expected_result }
        end

        context 'when different days' do
          let(:from) { Time.new 2013, 2, 5, 3, 2, 0 }
          let(:to)   { Time.new 2013, 1, 31, 23, 59, 59 }

          it { is_expected.to eq expected_result }
        end
      end
    end

    describe 'months' do
      let(:expected_result) do
        {
          years: 0,
          months: 5,
          days: 4,
          hours: 3,
          minutes: 2,
          seconds: 1
        }
      end

      context 'when future' do
        context 'when the same day' do
          let(:from) { Time.new 2013, 1, 1, 0, 0, 0 }
          let(:to)   { Time.new 2013, 6, 5, 3, 2, 1 }

          it { is_expected.to eq expected_result }
        end

        context 'when different days' do
          let(:from) { Time.new 2013, 1, 31, 23, 59, 59 }
          let(:to)   { Time.new 2013, 7, 5, 3, 2, 0 }

          it { is_expected.to eq expected_result }
        end
      end

      context 'when past' do
        context 'when the same day' do
          let(:from) { Time.new 2013, 6, 5, 3, 2, 1 }
          let(:to)   { Time.new 2013, 1, 1, 0, 0, 0 }

          it { is_expected.to eq expected_result }
        end

        context 'when different days' do
          let(:from) { Time.new 2013, 7, 5, 3, 2, 0 }
          let(:to)   { Time.new 2013, 1, 31, 23, 59, 59 }

          it { is_expected.to eq expected_result }
        end
      end
    end

    describe 'years' do
      let(:expected_result) do
        {
          years: 6,
          months: 5,
          days: 4,
          hours: 3,
          minutes: 2,
          seconds: 1
        }
      end

      context 'when future' do
        context 'when the same day' do
          let(:from) { Time.new 2013, 1, 1, 0, 0, 0 }
          let(:to)   { Time.new 2019, 6, 5, 3, 2, 1 }

          it { is_expected.to eq expected_result }
        end

        context 'when different days' do
          let(:from) { Time.new 2013, 1, 31, 23, 59, 59 }
          let(:to)   { Time.new 2019, 7, 5, 3, 2, 0 }

          it { is_expected.to eq expected_result }
        end
      end

      context 'when past' do
        context 'when the same day' do
          let(:from) { Time.new 2019, 6, 5, 3, 2, 1 }
          let(:to)   { Time.new 2013, 1, 1, 0, 0, 0 }

          it { is_expected.to eq expected_result }
        end

        context 'when different days' do
          let(:from) { Time.new 2019, 7, 5, 3, 2, 0 }
          let(:to)   { Time.new 2013, 1, 31, 23, 59, 59 }

          it { is_expected.to eq expected_result }
        end
      end
    end

    context 'leap year' do
      let(:expected_result) do
        {
          years: 0,
          months: 0,
          days: 2,
          hours: 0,
          minutes: 0,
          seconds: 0
        }
      end

      let(:from) { Time.new 2008, 2, 28 }
      let(:to)   { Time.new 2008, 3, 1 }

      it { is_expected.to eq expected_result }
    end
  end

  describe '#same?' do
    subject { Moments::Difference.new(from, to).same? }

    context 'with the same dates' do
      let(:to) { from }

      it { is_expected.to eq true }
    end

    context 'when `from` is earlier than `to`' do
      let(:from) { Time.new 2020, 1, 1 }
      let(:to)   { Time.new 2020, 1, 2 }

      it { is_expected.to eq false }
    end

    context 'when `to` is earlier than `from`' do
      let(:from) { Time.new 2020, 1, 2 }
      let(:to)   { Time.new 2020, 1, 1 }

      it { is_expected.to eq false }
    end
  end

  describe '#future?' do
    subject { Moments::Difference.new(from, to).future? }

    context 'with the same dates' do
      let(:to) { from }

      it { is_expected.to eq false }
    end

    context 'when `from` is earlier than `to`' do
      let(:from) { Time.new 2020, 1, 1 }
      let(:to)   { Time.new 2020, 1, 2 }

      it { is_expected.to eq true }
    end

    context 'when `to` is earlier than `from`' do
      let(:from) { Time.new 2020, 1, 2 }
      let(:to)   { Time.new 2020, 1, 1 }

      it { is_expected.to eq false }
    end
  end

  describe '#past?' do
    subject { Moments::Difference.new(from, to).past? }

    context 'with the same dates' do
      let(:to) { from }

      it { is_expected.to eq false }
    end

    context 'when `from` is earlier than `to`' do
      let(:from) { Time.new 2020, 1, 1 }
      let(:to)   { Time.new 2020, 1, 2 }

      it { is_expected.to eq false }
    end

    context 'when `to` is earlier than `from`' do
      let(:from) { Time.new 2020, 1, 2 }
      let(:to)   { Time.new 2020, 1, 1 }

      it { is_expected.to eq true }
    end
  end
end

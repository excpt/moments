# frozen_string_literal: true

describe_class Moments::Difference do
  # Thu, 04 Aug 2022 15:52:25 MDT -06:00
  let(:from) { Time.new(2022, 8, 4, 15, 52, 25, '-06:00') }
  # Thu, 18 Aug 2022 15:52:31 MDT -06:00
  let(:to) { Time.new(2022, 8, 18, 15, 52, 31, '-06:00') }

  describe 'minutes' do
    context 'with precision' do
      subject { Moments.difference(from, to, :precise).in_minutes }

      it { is_expected.to eq 20_160.1 }
    end
  end

  describe 'hours' do
    context 'with precision' do
      subject { Moments.difference(from, to, :precise).in_hours }

      it { is_expected.to eq 336.001666666666667 }
    end
  end

  describe 'days' do
    context 'with precision' do
      subject { Moments.difference(from, to, :precise).in_days }

      it { is_expected.to eq 14.000069444444444 }
    end
  end

  describe 'weeks' do
    context 'with precision' do
      subject { Moments.difference(from, to, :precise).in_weeks }

      it { is_expected.to eq 2.0000099206349207 }
    end
  end
end

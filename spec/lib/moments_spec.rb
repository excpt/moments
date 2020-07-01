# frozen_string_literal: true

describe Moments do
  describe '#difference' do
    subject { Moments.difference(from, to) }

    let(:from) { Time.new 2012, 1, 1 }
    let(:to)   { Time.new 2013, 1, 1 }

    it { is_expected.to be_a Moments::Difference }
  end
end

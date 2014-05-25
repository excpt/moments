require_relative '../../../lib/moments/difference'

describe Moments::Difference do
  let(:from) do
    Time.new 2012, 1, 1
  end

  let(:to) do
    Time.new 2013, 1, 1
  end

  it 'requires from and to times' do
    expect do
      Moments::Difference.new
    end.to raise_error ArgumentError

    expect do
      Moments::Difference.new from, to
    end.to_not raise_error
  end
end

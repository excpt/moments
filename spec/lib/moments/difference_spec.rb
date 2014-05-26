require_relative '../../../lib/moments/difference'

describe Moments::Difference do
  let(:from) do
    Time.new 2007, 1, 1
  end

  let(:to) do
    Time.new 2012, 1, 1
  end

  it 'requires from and to times' do
    expect do
      Moments::Difference.new
    end.to raise_error

    expect do
      Moments::Difference.new from, to
    end.to_not raise_error
  end

  it 'raise error if from > to' do
    expect do
      Moments::Difference(to, from)
    end.to raise_error
  end

  context '#to_hash' do
    context 'equal dates' do
      it '2013-01-01, 2013-01-01' do
        from = Time.new 2013, 1, 1
        to   = from

        expectation = { years: 0, months: 0, days: 0, hours: 0, minutes: 0, seconds: 0 }

        Moments::Difference.new(from, to).to_hash.should == expectation
      end
    end

    context 'seconds' do
      it '2013-01-01 00:00:00, 2013-01-01 00:00:01' do
        from = Time.new 2013, 1, 1, 0, 0, 0
        to   = Time.new 2013, 1, 1, 0, 0, 1

        expectation = { years: 0, months: 0, days: 0, hours: 0, minutes: 0, seconds: 1 }

        Moments::Difference.new(from, to).to_hash.should == expectation
      end

      it '2013-01-31 23:59:59, 2013-02-01 00:00:00' do
        from = Time.new 2013, 1, 31, 23, 59, 59
        to   = Time.new 2013, 2, 1, 0, 0, 0

        expectation = { years: 0, months: 0, days: 0, hours: 0, minutes: 0, seconds: 1 }

        Moments::Difference.new(from, to).to_hash.should == expectation
      end
    end

    context 'minutes' do
      it '2013-01-01 00:00:00, 2013-01-01 00:01:01' do
        from = Time.new 2013, 1, 1, 0, 0, 0
        to   = Time.new 2013, 1, 1, 0, 1, 1

        expectation = { years: 0, months: 0, days: 0, hours: 0, minutes: 1, seconds: 1 }

        Moments::Difference.new(from, to).to_hash.should == expectation
      end

      it '2013-01-31 23:59:59, 2013-02-01 00:01:00' do
        from = Time.new 2013, 1, 31, 23, 59, 59
        to   = Time.new 2013, 2, 1, 0, 1, 0

        expectation = { years: 0, months: 0, days: 0, hours: 0, minutes: 1, seconds: 1 }

        Moments::Difference.new(from, to).to_hash.should == expectation
      end
    end

    context 'hours' do
      it '2013-01-01 00:00:00, 2013-01-01 01:01:01' do
        from = Time.new 2013, 1, 1, 0, 0, 0
        to   = Time.new 2013, 1, 1, 1, 1, 1

        expectation = { years: 0, months: 0, days: 0, hours: 1, minutes: 1, seconds: 1 }

        Moments::Difference.new(from, to).to_hash.should == expectation
      end

      it '2013-01-31 23:59:59, 2013-02-01 01:01:00' do
        from = Time.new 2013, 1, 31, 23, 59, 59
        to   = Time.new 2013, 2, 1, 1, 1, 0

        expectation = { years: 0, months: 0, days: 0, hours: 1, minutes: 1, seconds: 1 }

        Moments::Difference.new(from, to).to_hash.should == expectation
      end
    end

    context 'days' do
      it '2013-01-01, 2013-01-02' do
        from = Time.new 2013, 1, 1
        to   = Time.new 2013, 1, 2

        expectation = { years: 0, months: 0, days: 1, hours: 0, minutes: 0, seconds: 0 }

        Moments::Difference.new(from, to).to_hash.should == expectation
      end

      it '2013-01-31, 2013-02-01' do
        from = Time.new 2013, 1, 31
        to   = Time.new 2013, 2, 1

        expectation = { years: 0, months: 0, days: 1, hours: 0, minutes: 0, seconds: 0 }

        Moments::Difference.new(from, to).to_hash.should == expectation
      end
    end

    context 'months' do
      it '2013-01-01, 2013-02-01' do
        from = Time.new 2013, 1, 1
        to   = Time.new 2013, 2, 2

        expectation = { years: 0, months: 1, days: 1, hours: 0, minutes: 0, seconds: 0 }

        Moments::Difference.new(from, to).to_hash.should == expectation
      end

      it '2013-01-31, 2013-03-01' do
        from = Time.new 2013, 1, 31
        to   = Time.new 2013, 3, 1

        expectation = { years: 0, months: 1, days: 1, hours: 0, minutes: 0, seconds: 0 }

        Moments::Difference.new(from, to).to_hash.should == expectation
      end
    end

    context 'years' do
      it '2013-01-01, 2014-01-01' do
        from = Time.new 2013, 1, 1
        to   = Time.new 2014, 2, 2

        expectation = { years: 1, months: 1, days: 1, hours: 0, minutes: 0, seconds: 0 }

        Moments::Difference.new(from, to).to_hash.should == expectation
      end

      it '2013-01-31, 2014-03-01' do
        from = Time.new 2013, 1, 31
        to   = Time.new 2014, 3, 1

        expectation = { years: 1, months: 1, days: 1, hours: 0, minutes: 0, seconds: 0 }

        Moments::Difference.new(from, to).to_hash.should == expectation
      end
    end

    context 'leap year' do
      it '2008-02-27, 2008-02-029' do
        from = Time.new 2008, 2, 27
        to   = Time.new 2008, 2, 29

        expectation = { years: 0, months: 0, days: 2, hours: 0, minutes: 0, seconds: 0 }

        Moments::Difference.new(from, to).to_hash.should == expectation
      end

      it '2008-02-27, 2008-03-01' do
        from = Time.new 2008, 2, 27
        to   = Time.new 2008, 3, 1

        expectation = { years: 0, months: 0, days: 3, hours: 0, minutes: 0, seconds: 0 }

        Moments::Difference.new(from, to).to_hash.should == expectation
      end
    end
  end

  it '#same?' do
    moments = Moments::Difference.new(from, from)

    moments.same?.should == true
    moments.past?.should == false
  end

  it '#future?' do
    moments = Moments::Difference.new(from, to)

    moments.future?.should == true
    moments.past?.should == false
  end
end

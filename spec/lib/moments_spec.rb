require 'spec_helper'
require_relative '../../lib/moments.rb'

describe Moments do
  context 'calculates the distance between two given times' do
    let(:from) do
      Time.new 2012, 1, 1
    end

    let(:to) do
      Time.new 2013, 1, 1
    end

    it '#difference requires a start and end time' do
      expect do
        Moments.difference(from, to)
      end.to_not raise_error

      Moments.difference(from, to).should be_a Moments::Difference
    end

    it '#difference should raise an error if :from is greater than :to' do
      expect do
        Moments.difference(to, from)
      end.to raise_error
    end
  end
end

# encoding: utf-8
require 'moments/version'
require 'moments/difference'

# Moments base module
module Moments
  def self.difference(from, to)
    Moments::Difference.new from, to
  end
end

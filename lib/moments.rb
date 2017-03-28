require 'moments/version'
require 'moments/difference'

module Moments
  def self.difference(from, to)
    Moments::Difference.new from, to
  end
end

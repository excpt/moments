require 'moments/version'
require 'moments/difference'

# Entrypoint for the moments gem
module Moments
  def self.difference(from, to)
    Moments::Difference.new from, to
  end
end

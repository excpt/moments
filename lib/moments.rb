# frozen_string_literal: true

require_relative 'moments/version'
require_relative 'moments/difference'

# Entrypoint for the moments gem
module Moments
  def self.difference(from, to)
    Moments::Difference.new from, to
  end
end

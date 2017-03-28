# Moments::Version module
module Moments
  def self.gem_version
    Gem::Version.new VERSION::STRING
  end

  # Moments version builder module
  module VERSION
    # major version
    MAJOR = 0
    # minor version
    MINOR = 0
    # tiny version
    TINY  = 2
    # alpha, beta, etc. tag
    PRE   = 'alpha'.freeze

    # Build version string
    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')
  end
end

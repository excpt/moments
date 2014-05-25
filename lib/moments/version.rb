module Moments
  def self.gem_version
    Gem::Version.new VERSION::STRING
  end

  module VERSION
    MAJOR = 0
    MINOR = 0
    TINY  = 1
    PRE   = 'dev'

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')
  end
end

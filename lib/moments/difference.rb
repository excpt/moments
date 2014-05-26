module Moments
  class Difference
    def initialize(from, to)
      @from = from
      @to   = to

      if past?
        message = "Start date (#{from}) must be less or equal than the end date (#{@to})."
        raise ArgumentError.new(message)
      end

      precise_difference
    end

    def to_hash
      @diff
    end

    def future?
      @from < @to
    end

    def same?
      @from == @to
    end

    def past?
      @from > @to
    end

    def precise_difference
      seconds = @to.sec - @from.sec
      minutes = @to.min - @from.min
      hours   = @to.hour - @from.hour
      days    = @to.day - @from.day
      months  = @to.month - @from.month
      years   = @to.year - @from.year

      @diff = {
          years:   years,
          months:  months,
          days:    days,
          hours:   hours,
          minutes: minutes,
          seconds: seconds
      }
    end

    private :precise_difference
  end
end
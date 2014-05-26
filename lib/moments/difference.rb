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

      if seconds < 0
        seconds += 60
        minutes -= 1
      end

      if minutes < 0
        minutes += 60
        hours   -= 1
      end

      if hours < 0
        hours += 24
        days  -= 1
      end

      if days < 0
        previous_month_days = (Time.new(@to.year, @to.month, 1) - 1).day

        if previous_month_days < @from.day
          days = previous_month_days + days + (@from.day - previous_month_days)
        else
          days = previous_month_days + days
        end

        months -= 1
      end

      if months < 0
        months += 12
        years -= 1
      end

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
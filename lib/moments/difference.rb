module Moments
  class Difference
    def initialize(from, to)
      @from = from
      @to   = to

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
      to   = @to
      from = @from

      if to > from
        to   = @from
        from = @to
      end

      @diff = {
          seconds: to.sec - from.sec,
          minutes: to.min - from.min,
          hours:   to.hour - from.hour,
          days:    to.day - from.day,
          months:  to.month - from.month,
          years:   to.year - from.year,
      }

      calculate :seconds, :minutes
      calculate :minutes, :hours
      calculate :hours, :days, 24
      calculate_days
      calculate :months, :years, 12

      @diff
    end

    private :precise_difference

    def calculate(attribute, difference, stepping = 60)
      if @diff[attribute] < 0
        @diff[attribute]  += stepping
        @diff[difference] -= 1
      end
    end

    private :calculate

    def calculate_days
      if @diff[:days] < 0
        previous_month_days = (Time.new(@to.year, @to.month, 1) - 1).day
        @diff[:days]        = precise_previous_month_days(@diff[:days], previous_month_days, @from.day)
        @diff[:months]      -= 1
      end
    end

    private :calculate_days

    def precise_previous_month_days(days, previous, from)
      if previous < from
        days = previous + days + (from - previous)
      else
        days = previous + days
      end

      days
    end

    private :precise_previous_month_days
  end
end

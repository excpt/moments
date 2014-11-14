module Moments
  class Difference
    def initialize(from, to)
      @from = from
      @to   = to

      if past?
        message = "Start date (#{from}) must be less or equal than the end date (#{@to})."
        raise ArgumentError.new(message)
      end

      @diff = {
        seconds: @to.sec - @from.sec,
        minutes: @to.min - @from.min,
        hours: @to.hour - @from.hour,
        days: @to.day - @from.day,
        months: @to.month - @from.month,
        years: @to.year - @from.year,
      }

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
      calculate_seconds
      calculate_minutes
      calculate_hours
      calculate_days
      calculate_months

      @diff
    end

    private :precise_difference

    def calculate_seconds
      if @diff[:seconds] < 0
        @diff[:seconds] += 60
        @diff[:minutes] -= 1
      end
    end

    private :calculate_seconds

    def calculate_minutes
      if @diff[:minutes] < 0
        @diff[:minutes] += 60
        @diff[:hours] -= 1
      end
    end

    private :calculate_minutes

    def calculate_hours
      if @diff[:hours] < 0
        @diff[:hours] += 24
        @diff[:days] -= 1
      end
    end

    private :calculate_hours

    def calculate_days
      if @diff[:days] < 0
        previous_month_days = (Time.new(@to.year, @to.month, 1) - 1).day
        @diff[:days] = precise_previous_month_days(@diff[:days], previous_month_days, @from.day)
        @diff[:months] -= 1
      end
    end

    private :calculate_days

    def calculate_months
      if @diff[:months] < 0
        @diff[:months] += 12
        @diff[:years] -= 1
      end
    end

    private :calculate_months

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

module Moments
  # Calculates differences between two given Time instances.
  class Difference
    # == Parameters:
    # from::
    #   A instance of Time
    # to::
    #   A instance of Time
    def initialize(from, to)
      @from = from
      @to   = to
      @diff = {
        seconds: 0,
        minutes: 0,
        hours: 0,
        days: 0,
        months: 0,
        years: 0
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
      from, to = ordered_time
      @diff = calculate_diff from, to

      calculate :seconds, :minutes
      calculate :minutes, :hours
      calculate :hours, :days, 24
      calculate_days
      calculate :months, :years, 12

      @diff
    end
    private :precise_difference

    def calculate_diff(from, to)
      {
        seconds: to.sec - from.sec,
        minutes: to.min - from.min,
        hours:   to.hour - from.hour,
        days:    to.day - from.day,
        months:  to.month - from.month,
        years:   to.year - from.year
      }
    end
    private :calculate_diff

    def ordered_time
      to   = @to
      from = @from

      if from > to
        to   = @from
        from = @to
      end

      [from, to]
    end
    private :ordered_time

    def calculate(attribute, difference, stepping = 60)
      return if @diff[attribute] >= 0

      @diff[attribute] += stepping
      @diff[difference] -= 1
    end
    private :calculate

    def calculate_days
      return if @diff[:days] >= 0

      previous_month_days = (Time.new(@to.year, @to.month, 1) - 1).day
      @diff[:days] = precise_previous_month_days(@diff[:days], previous_month_days, @from.day)
      @diff[:months] -= 1
    end
    private :calculate_days

    def precise_previous_month_days(days, previous, from)
      if previous < from
        previous + days + (from - previous)
      else
        previous + days
      end
    end
    private :precise_previous_month_days
  end
end

# frozen_string_literal: true

module Moments
  # Calculates differences between two given Time instances.
  class Difference
    PARTS = {
      years: :year,
      months: :month,
      days: :day,
      hours: :hour,
      minutes: :min,
      seconds: :sec
    }.freeze

    private_constant :PARTS

    # == Parameters:
    # from::
    #   A instance of Time
    # to::
    #   A instance of Time
    def initialize(from, to)
      @from = from
      @to   = to
      @diff = PARTS.transform_values { 0 }

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

    private

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

    def calculate_diff(from, to)
      PARTS.transform_values do |method_name|
        to.public_send(method_name) - from.public_send(method_name)
      end
    end

    def ordered_time
      [@from, @to].sort
    end

    def calculate(attribute, difference, stepping = 60)
      return if @diff[attribute] >= 0

      @diff[attribute] += stepping
      @diff[difference] -= 1
    end

    def calculate_days
      return if @diff[:days] >= 0

      previous_month_days = (Time.new(@to.year, @to.month, 1) - 1).day
      @diff[:days] = precise_previous_month_days(@diff[:days], previous_month_days, @from.day)
      @diff[:months] -= 1
    end

    def precise_previous_month_days(days, previous, from)
      if previous < from
        previous + days + (from - previous)
      else
        previous + days
      end
    end
  end
end

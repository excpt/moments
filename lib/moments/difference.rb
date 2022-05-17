# frozen_string_literal: true

require 'date'

module Moments
  # Calculates differences between two given Time instances.
  class Difference
    DATE_PARTS = {
      years: :year,
      months: :month,
      days: :day
    }.freeze

    TIME_PARTS = {
      hours: :hour,
      minutes: :min,
      seconds: :sec
    }.freeze

    private_constant :DATE_PARTS, :TIME_PARTS

    # == Parameters:
    # from::
    #   A instance of Time
    # to::
    #   A instance of Time
    def initialize(from, to)
      @from = parse_argument from
      @to = parse_argument to

      @ordered_from, @ordered_to = [@from, @to].sort

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

    def in_seconds
      @ordered_to.to_i - @ordered_from.to_i
    end

    def in_minutes
      in_seconds / 60
    end

    def in_hours
      in_minutes / 60
    end

    def in_days
      in_hours / 24
    end

    def in_weeks
      in_days / 7
    end

    def in_months
      months_diff = @ordered_to.month - @ordered_from.month
      months_diff -= 1 if months_diff.positive? && @ordered_to.mday < @ordered_from.mday

      (@ordered_to.year - @ordered_from.year) * 12 + months_diff
    end

    def in_years
      years_diff = @ordered_to.year - @ordered_from.year

      return years_diff unless years_diff.positive?
      return years_diff if @ordered_to.month > @ordered_from.month

      if (@ordered_to.month < @ordered_from.month) || (@ordered_to.mday < @ordered_from.mday)
        years_diff -= 1
      end

      years_diff
    end

    private

    TIME_CLASSES = [Time, DateTime].freeze

    private_constant :TIME_CLASSES

    def parse_argument(value)
      case value
      when *TIME_CLASSES
        value.to_time.getutc
      when Date
        value
      else
        raise ArgumentError, 'Unsupported format'
      end
    end

    def precise_difference
      @diff = calculate_diff

      calculate :seconds, :minutes
      calculate :minutes, :hours
      calculate :hours, :days, 24
      calculate_days
      calculate :months, :years, 12

      @diff
    end

    def calculate_diff
      are_time_parts = [@from, @to].all? do |value|
        TIME_CLASSES.any? { |time_class| value.is_a?(time_class) }
      end

      (are_time_parts ? DATE_PARTS.merge(TIME_PARTS) : DATE_PARTS)
        .transform_values do |method_name|
          @ordered_to.public_send(method_name) - @ordered_from.public_send(method_name)
        end
    end

    def calculate(attribute, difference, stepping = 60)
      return unless @diff.key?(attribute) && @diff.key?(difference)

      return if @diff[attribute] >= 0

      @diff[attribute] += stepping
      @diff[difference] -= 1
    end

    def calculate_days
      return if @diff[:days] >= 0

      previous_month_days = (Time.new(@to.year, @to.month, 1) - 1).day
      @diff[:days] = precise_previous_month_days(
        @diff[:days], previous_month_days, @from.day
      )
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

require 'quarter_time'

class AdMobApi
  class DateRange < Range
    class << self
      def today
        today = Date.today
        DateRange.new(today, today)
      end

      def yesterday
        today = Date.today
        DateRange.new(today - 1, today - 1)
      end

      def last_days(days)
        today = Date.today
        DateRange.new(today - days, today)
      end

      def previous_month
        one_month_ago = Date.today << 1
        DateRange.new(begining_of_the_month(one_month_ago), end_of_the_month(one_month_ago))
      end

      def previous_quarter
        today   = Date.today
        quarter = Quarter.new(today.year, today.quarter).previous
        DateRange.new(quarter.start_date, quarter.end_date)
      end

      def month_to_date
        today = Date.today
        DateRange.new(begining_of_the_month(today), today)
      end

      def quarter_to_date
        today   = Date.today
        quarter = Quarter.new(today.year, today.quarter)
        DateRange.new(quarter.start_date, today)
      end

      def year_to_date
        today = Date.today
        DateRange.new(Date.new(today.year, 1, 1), today)
      end

    private
      def begining_of_the_month(date)
        Date.new(date.year, date.month, 1)
      end

      def end_of_the_month(date)
        one_month_later = date >> 1
        begining_of_the_month(one_month_later) - 1
      end

      def method_missing(method_name, *args, &block)
        if method_name =~ /last_(\d+)days/
          send(:last_days, $1.to_i)
        else
          super
        end
      end
    end
  end
end

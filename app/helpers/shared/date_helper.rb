module Shared
  module DateHelper
    # Create a time_tag given a Date, Time, or DateTime object.
    #
    # @param date [Date|Time|DateTime] Date to format for tag
    # @return [String] String containing HTML for time tag with a datetime attribute and text of “mm/dd/yyyy”
    def date_tag(date)
      time_tag date, format: '%m/%d/%Y', datetime: date.strftime('%m/%d/%Y')
    end
  end
end

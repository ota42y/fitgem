module Fitgem
  class Client
    # ==========================================
    #       Heart Rate Retrieval Methods
    # ==========================================

    # Heart Rate Intraday Time Series
    # https://dev.fitbit.com/docs/heart-rate/#get-heart-rate-intraday-time-series
    # @param [DateTime, Date, String] date
    # @return [Hash] Hash containing an average of the days logs, and a
    #   list of all individual entries
    def heart_rate_intraday_time_series(date, options = {})
      range = construct_heat_rate_date_range_fragment(options)
      url = "/user/-/activities/heart/date/#{format_date(date)}#{range}.json"
      get(url)
    end

    # https://api.fit
    def construct_heat_rate_date_range_fragment(options)
      range_str = []
      if options[:end_date]
        # /[end-date]/[detail-level].json
        # /[end-date]/[detail-level]/time/[start-time]/[end-time].json
        range_str << "/#{format_date(options:end_date)}"
      else
        # /1d/[detail-level].json
        # /1d/[detail-level]/time/[start-time]/[end-time].json
        range_str << '/1d'
      end

      range_str << "/#{options[:detail_level]}" if options[:detail_level]

      if options[:start_time] && options[:end_time]
        range_str << "/time/#{options[:start_time]}/#{options[:end_time]}"
      end

      range_str.join('')
    end
  end
end

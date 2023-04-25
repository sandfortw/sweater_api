class RoadTripFacade
  def initialize(payload)
    @payload = payload
  end

  def road_trip
    route = RouteService.new(@payload).get_route
    if route[:info][:statuscode] == 402
      {
        start_city: @payload[:origin],
        end_city: @payload[:destination],
        travel_time: 'Impossible',
        weather_at_eta: {}
      }
    else
      unix_time_of_arrival = Time.now.to_i + route[:route][:realTime]
      time_of_arrival = Time.at(unix_time_of_arrival).strftime('%Y-%m-%d')
      hour_of_arrival = Time.at(unix_time_of_arrival).hour
      forecast = ForecastService.new({ d: @payload[:destination], t: time_of_arrival,
                                       h: hour_of_arrival }).get_forecast_by_unix
      {
        start_city: @payload[:origin],
        end_city: @payload[:destination],
        travel_time: route[:route][:formattedTime],
        weather_at_eta: {
          datetime: Time.at(unix_time_of_arrival).strftime('%Y-%m-%d %H:%M'),
          temperature: forecast[:forecast][:forecastday][0][:hour][0][:temp_f],
          condition: forecast[:forecast][:forecastday][0][:hour][0][:condition][:text]
        }
      }
    end
  end
end

class ForecastSerializer
  include JSONAPI::Serializer

  set_id { nil }
  set_type :forecast

  attribute :current_weather do |object|
    {
      last_updated: object[:current][:last_updated],
      temperature: object[:current][:temp_f],
      feels_like: object[:current][:feelslike_f],
      humidity: object[:current][:humidity],
      uvi: object[:current][:uv],
      visibility: object[:current][:vis_miles],
      condition: object[:current][:condition][:text],
      icon: object[:current][:condition][:icon]
    }
  end

  attribute :daily_weather do |object|
    object[:forecast][:forecastday].map do |day|
      {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        condition: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end
  end

  attribute :hourly_weather do |object|
    object[:forecast][:forecastday][0][:hour].map do |hour|
      {
        time: hour[:time].split(' ')[1],
        temperature: hour[:temp_f],
        conditions: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end
  end
end
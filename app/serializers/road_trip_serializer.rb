# frozen_string_literal: true

class RoadTripSerializer
  include JSONAPI::Serializer

  set_id { nil }
  set_type :road_trip


  attribute :start_city do |object|
    object[:start_city]
  end

  attribute :end_city do |object|
    object[:end_city]
  end

  attribute :travel_time do |object|
    object[:travel_time]
  end

  attribute :weather_at_eta do |object|
    object[:weather_at_eta]
  end
end
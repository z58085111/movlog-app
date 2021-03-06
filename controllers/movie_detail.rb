# frozen_string_literal: true

# MovlogAPP web service
class MovlogApp < Sinatra::Base
  get "/rooms/:location/?" do
    room_request = LocationRequest.call(params)
    results = FindRoomsFromApi.call(room_request)
    if results.success?
      content_type 'application/json'
      results.value
    end
  end

  get "/airports/:location/?" do
    airport_request = LocationRequest.call(params)
    results = FindAirportsFromApi.call(airport_request)
    if results.success?
      content_type 'application/json'
      results.value
    end
  end

  get "/flights/:origin/:destination/?" do
    flight_request =  FlightRequest.call(params)
    results = FindFlightsFromApi.call(flight_request)
    if results.success?
      content_type 'application/json'
      results.value
    end
  end
end

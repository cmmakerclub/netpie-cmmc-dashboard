require 'httparty'

SCHEDULER.every '1m', :first_in => 0 do |job|
  begin
    # Hit Xively JSON endpoint
    datastream = HTTParty.get("https://api.xively.com/v2/feeds/469207408",
                { :headers => { 'X-ApiKey' => "EnYoLFD1lVO3YJK3GPzwj3WQ60jcQmSU0Fo0qiN6mYLYD1Ax", "Content-Type" => 'application/json'}})


    datastreams = datastream['datastreams']
     
    # Get the current value
    temperature_value = datastreams.find { | ds | ds['id'] ==  "temperature-average" }['current_value']
    humidity_value = datastreams.find { | ds | ds['id'] ==  "humidity-average" }['current_value']

    current_value = datastream['current_value']
    puts temperature_value
    puts humidity_value

    # Bind data to the DOM 
    send_event('xively_data_temperature', { current: temperature_value })
    send_event('xively_data_humidity', { current: humidity_value})
    send_event('weather', { current: "CMMC"})
  end
end

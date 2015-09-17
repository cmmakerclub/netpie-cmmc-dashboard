require 'mqtt'

# Set your MQTT server
MQTT_SERVER = 'rabbit.cmmc.ninja'

# Set the MQTT topics you're interested in and the tag (data-id) to send for dashing events
MQTT_TOPICS = { 
               'esp8266/cmmc-temp1/command' => 'temp1',
               'esp8266/cmmc-humid1/command' => 'humid1',
               'esp8266/cityview-temp1/command' => 'citytemp1',
               'esp8266/cityview-humid1/command' => 'cityhumid1',
               'esp8266/opendream-temp1/command' => 'opendreamtemp1',
               'esp8266/opendream-humid1/command' => 'opendreamhumid1',
              }

    # send_event('xively_data_temperature', { current: temperature_value })
    # send_event('xively_data_humidity', { current: humidity_value})
    # send_event('weather', { current: "CMMC"})
# Start a new thread for the MQTT client
print "HELLO"
Thread.new {
  MQTT::Client.connect(
    :host => MQTT_SERVER,
    :username => 'nat:dashing',
    :password => 'dashing'
  ) do |client|
    print "BEGIN"

    client.subscribe( MQTT_TOPICS.keys )

    # Sets the default values to 0 - used when updating 'last_values'
    # current_values = Hash.new(0)

    print "OK"
    client.get do |topic,message|
      # print message
      tag = MQTT_TOPICS[topic]
      # nat = message
      # print nat
      # print "\n"
      # temperature_value =  nat['d']['temp']
      # humidity_value =  nat['d'][1]['humid']


      # print "?"
      # print tag
      # print nat['d']['myName']
      # print temperature_value
      # last_value = current_values[tag]
      # current_values[tag] = message
      # send_event(tag, { value: message, current: message, last: last_value })

      if tag == "temp1"
        send_event('xively_data_temperature', { current: message})
      end
      if tag == "humid1"
        send_event('xively_data_humidity', { current: message})
      end
      if tag == "citytemp1"
        send_event('cityview_data_temperature', { current: message})
      end
      if tag == "cityhumid1"
        send_event('cityview_data_humidity', { current: message})
      end
      if tag == "opendreamtemp1"
        send_event('opendream_data_temperature', { current: message})
      end
      if tag == "opendreamhumid1"
        send_event('opendream_data_humidity', { current: message})
      end
    end
  end
}
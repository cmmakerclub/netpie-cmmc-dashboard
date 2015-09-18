require 'mqtt'

# Set your MQTT server
MQTT_SERVER = 'gearbroker.netpie.io'

# Set the MQTT topics you're interested in and the tag (data-id) to send for dashing events
MQTT_TOPICS = { 
               '/HelloChiangMaiMakerClub/gearname/dashing/temp1' => 'temp1',
               '/HelloChiangMaiMakerClub/gearname/dashing/temp2' => 'temp2',
               '/HelloChiangMaiMakerClub/gearname/dashing/humid1' => 'humid1',
               '/HelloChiangMaiMakerClub/gearname/dashing/humid2' => 'humid2',
               '/HelloChiangMaiMakerClub/gearname/dashing/text1' => 'text1',
               '/HelloChiangMaiMakerClub/gearname/dashing/text2' => 'text2',
               '/HelloChiangMaiMakerClub/gearname/dashing/counter1' => 'counter1',
               '/HelloChiangMaiMakerClub/gearname/dashing/counter2' => 'counter2',
               '/HelloChiangMaiMakerClub/gearname/dashing/heap1' => 'heap1',
               '/HelloChiangMaiMakerClub/gearname/dashing/heap2' => 'heap2',
              }

    # send_event('xively_data_temperature', { current: temperature_value })
    # send_event('xively_data_humidity', { current: humidity_value})
    # send_event('weather', { current: "CMMC"})
# Start a new thread for the MQTT client
print "HELLO"
Thread.new {
  MQTT::Client.connect(
    :host => MQTT_SERVER,
    :username => '2syAvlZPSExXY3M%1442403100',
    :client_id=> 'qWeTbE1JFpwgXLnL',
    :password => 'CyMMKKHSrG1x+NSZNWSps6UeoqE='
  ) do |client|
    print "BEGIN"

    client.subscribe( MQTT_TOPICS.keys )

    # Sets the default values to 0 - used when updating 'last_values'
    # current_values = Hash.new(0)

    print "OK"
    client.get do |topic,message|
      print message
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
      if tag == "temp2"
        send_event('cityview_data_temperature', { current: message})
      end
      if tag == "humid2"
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
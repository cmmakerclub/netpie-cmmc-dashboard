require 'mqtt'
require 'json'

# Set your MQTT server
MQTT_SERVER = 'gearbroker.netpie.io'

# Set the MQTT topics you're interested in and the tag (data-id) to send for dashing events
MQTT_TOPICS = { 
               '/HelloChiangMaiMakerClub/gearname/oN8smWzJ2H0wwcra/status' => 'cooler001',
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

    client.subscribe([
      "/HelloChiangMaiMakerClub/gearname/#/status",
      "/HelloChiangMaiMakerClub/gearname/#"      
      ])
    # /HelloChiangMaiMakerClub/gearname/dashing/temp1/status

    # Sets the default values to 0 - used when updating 'last_values'
    # current_values = Hash.new(0)

    print "OK\n"
    client.get do |topic,message|
      tag = MQTT_TOPICS[topic]
      
      if tag == "cooler001" then
        print "IF \n"
        print message
        json = JSON.parse(message)
        
        temp = json['d']['temp']
        humid = json['d']['humid']
  
        heap = json['d']['heap']
        rssi = json['d']['rssi']      
        seconds = json['d']['seconds']
        counter = json['d']['counter']
        heap = json['d']['heap']                        
        print "\n"
        
        send_event('xively_data_temperature2', { current: temp, value: temp })
        send_event('xively_data_humidity2', { current: humid, value: humid })        
                
      
        send_event('xively_data_temperature', { current: temp, value: temp })
        send_event('xively_data_humidity', { current: humid, value: humid })   
        
        send_event('rssi', { current: rssi, value: rssi })
        send_event('counter', { current: counter, value: counter })         
        send_event('heap', { current: heap, value: heap })   
        send_event('seconds', { current: seconds, value: seconds })                
      else
        print "ELSE \n"
        print message + "\n"        
        print topic
      end


            
          
      # nat = message
      # print nat
      # print "\n"
      # temperature_value =  nat['d']['temp']
      # humidity_value =  nat['d'][1]['humid']
      # print message


      # print "?"
      # print tag
      # print nat['d']['myName']
      # print temperature_value
      # last_value = current_values[tag]
      # current_values[tag] = message
      # send_event(tag, { value: message, current: message, last: last_value })


    end
  end
}
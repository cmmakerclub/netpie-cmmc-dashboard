require 'mqtt'
require 'json'

MQTT_SERVER = 'gearbroker.netpie.io'
MQTT_TOPICS = { 
               '/HelloChiangMaiMakerClub/gearname/oN8smWzJ2H0wwcra/status' => 'cooler001',
               '/HelloChiangMaiMakerClub/gearname/dashing/3AzmocC7vZDC6yjD/command' => 'wattmeter'
              }


# /HelloChiangMaiMakerClub/gearname/TmNsJWqiLcKNm50i/status
# /HelloChiangMaiMakerClub/gearname/60YxYWu07XixBW5Q/status
SCHEDULER.every '60s', :first_in => 0 do |job|
  begin
    print "5S?"
    print "\n"
    MQTT::Client.connect(
    :host => MQTT_SERVER,
    :username => '2syAvlZPSExXY3M%1442403100',
    :client_id=> 'qWeTbE1JFpwgXLnL',
    :clean_session=> true,
    :password => 'CyMMKKHSrG1x+NSZNWSps6UeoqE='
    ) do |client|
        print client
        client.subscribe(["/HelloChiangMaiMakerClub/gearname/#/status"])
        client.get do |topic,message|
          tag = MQTT_TOPICS[topic]

          print " TOPIC "
          print topic
          print " TAG "
          print tag
          print "\n"
          if topic == "/HelloChiangMaiMakerClub/gearname/TmNsJWqiLcKNm50i/status" 
             # or topic == "/HelloChiangMaiMakerClub/gearname/60YxYWu07XixBW5Q/status"
            print "OK!"
            json = JSON.parse(message)
            print " MESSAGE "
            print message
            print "\n\n"
            
            temp = json['d']['temp']
            humid = json['d']['humid']
      
            heap = json['d']['heap']
            rssi = json['d']['rssi']
            seconds = json['d']['seconds']
            counter = json['d']['counter']
            heap = json['d']['heap']

            send_event('rssi', { current: rssi, value: rssi })
            send_event('counter', { current: counter, value: counter })
            send_event('heap', { current: heap, value: heap })
            send_event('seconds', { current: seconds, value: seconds })

            send_event('xively_data_temperature', { current: temp, value: temp })
            send_event('xively_data_humidity', { current: humid, value: humid })
           end
          # client.disconnect()
          # print "==DONE=="
        end


    end
    print "BEGIN"    
  end
end

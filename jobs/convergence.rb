# Populate the graph with some random points
require 'mqtt'

points = []
(1..10).each do |i|
  points << { x: i, y: rand(50) }
end
last_x = points.last[:x]

conn_opts = {
  remote_host: "128.199.104.122",
  # remote_port: uri.port,
  # username: uri.user,
  # password: uri.password,
}

Thread.new do
  MQTT::Client.connect(conn_opts) do |c|
    # The block will be called when you messages arrive to the topic
    puts "MQTT Connected"
    c.get('test') do |topic, message|
      puts "#{topic}: #{message}"
    end
  end
end


SCHEDULER.every '2s' do
  points.shift
  last_x += 1
  points << { x: last_x, y: rand(50) }

  # send_event('convergence', points: points)
end

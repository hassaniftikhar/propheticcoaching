# Run with: rackup private_pub.ru -s thin -E production
require "bundler/setup"
require "yaml"
require "private_pub"
require "redis"

Faye::WebSocket.load_adapter('thin')

PrivatePub.load_config(File.expand_path("../config/private_pub.yml", __FILE__), ENV["RAILS_ENV"] || "development")

server = PrivatePub.faye_app


@semaphore = Mutex.new
@online_clients=[]
$redis = Redis.new

server.bind :subscribe do |client_id, channel|

  @semaphore.synchronize {
    user_id = channel.split("/").last
    @online_clients.push(user_id) if user_id =~ /\d/
    @online_clients.uniq!
    $redis.set "online_clients", @online_clients.to_json
  }

  p "===== FAYE subscribe channel: #{channel}, online_users: #{@online_clients} ===="
end

server.bind :unsubscribe do |client_id, channel|
  @semaphore.synchronize {

    user_id = channel.split("/").last
    @online_clients.delete(user_id) if user_id =~ /\d/
    $redis.set "online_clients", @online_clients.to_json

  }
  p "===== FAYE unsubscribe channel: #{channel}, online_users: #{@online_clients} ===="
end

#server.bind :connect do |client_id, channel|
#  p "===== FAYE connect client_id: #{client_id}, channel: #{channel} ===="
#end
#
#server.bind :disconnect do |client_id, channel|
#  p "===== FAYE disconnect client_id: #{client_id}, channel: #{channel} ===="
#end

run server

#run PrivatePub.faye_app

uri = URI.parse(ENV["REDISTOGO_URL"] || "redis://localhost:6379/")
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
$redis = REDIS
redis.current = REDIS


# uri = URI.parse(ENV["REDISTOGO_URL"])
# uri = URI.parse(ENV["REDISTOGO_URL"] || "redis://localhost:6379/")
# REDIS = Redis.new(:url => ENV['REDISTOGO_URL'])




# $redis = Redis.new


# uri = URI.parse(ENV["REDISTOGO_URL"])
uri = URI.parse(ENV["REDISTOGO_URL"] || "redis://localhost:6379/")
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

# REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

# Resque.redis = Redis.new host:uri.host, port:uri.port, password:uri.password
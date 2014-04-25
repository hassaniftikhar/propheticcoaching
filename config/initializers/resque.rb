uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

# REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

# Resque.redis = Redis.new host:uri.host, port:uri.port, password:uri.password
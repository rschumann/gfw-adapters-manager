if ENV["REDISCLOUD_URL"]
    $redis = Redis.new(:url => ENV["REDISCLOUD_URL"])
else
  host   = ENV.fetch('REDIS_HOST')     { 'localhost' }
  port   = ENV.fetch('REDIS_PORT')     { 6379 }
  $redis = Redis.new(host: host, port: port)
end

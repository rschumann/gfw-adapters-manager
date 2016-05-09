require 'curb'
require 'uri'
require 'oj'
require 'oj_mimic_json'

class Datasets
  KEY = 'datasets'

  class << self
    def list
      items_caching do
        push
      end
    end

    def refresh(namespace)
      clear_redis_cache(namespace)
    end

    def push
      url = URI.decode('http://localhost:3000/summary')

      @c = Curl::Easy.http_get(URI.escape(url)) do |curl|
        curl.headers['Accept']       = 'application/json'
        curl.headers['Content-Type'] = 'application/json'
        curl.username                = ENV['ACCESS_USER']
        curl.password                = ENV['ACCESS_PASSWORD']
      end

      Oj.load(@c.body_str.force_encoding(Encoding::UTF_8))
    end

    def items_caching
      if cached = $redis.get(KEY)
        data = Oj.dump(eval(cached))
        Oj.load(data)
      else
        yield.tap do |items|
          $redis.set(KEY, items)
        end
      end
    end

    def clear_redis_cache(namespace)
      keys = $redis.keys "#{namespace}"
      $redis.del(*keys) unless keys.empty?
    end
  end
end
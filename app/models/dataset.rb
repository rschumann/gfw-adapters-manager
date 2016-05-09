require 'curb'
require 'uri'
require 'oj'
require 'oj_mimic_json'

class Dataset
  KEY = 'dataset'

  class << self
    def details(dataset_id)
      item_caching(dataset_id) do
        push(dataset_id)
      end
    end

    def refresh(namespace)
      clear_redis_cache(namespace)
    end

    def delete(dataset_id)
      url  = URI.decode("#{ENV['API_URL']}/summary/#{dataset_id}")

      @c = Curl::Easy.http_delete(URI.escape(url)) do |curl|
        curl.headers['Accept']       = 'application/json'
        curl.headers['Content-Type'] = 'application/json'
        curl.username                = ENV['ACCESS_USER']
        curl.password                = ENV['ACCESS_PASSWORD']
      end

      clear_redis_cache('datasets')
    end

    def push(dataset_id)
      url = URI.decode("#{ENV['API_URL']}/summary/#{dataset_id}")

      @c = Curl::Easy.http_get(URI.escape(url)) do |curl|
        curl.headers['Accept']       = 'application/json'
        curl.headers['Content-Type'] = 'application/json'
        curl.username                = ENV['ACCESS_USER']
        curl.password                = ENV['ACCESS_PASSWORD']
      end

      Oj.load(@c.body_str.force_encoding(Encoding::UTF_8))
    end

    def item_caching(dataset_id)
      if cached = $redis.get("#{KEY}_#{dataset_id}")
        data = Oj.dump(eval(cached))
        Oj.load(data)
      else
        yield.tap do |items|
          $redis.set("#{KEY}_#{dataset_id}", items)
        end
      end
    end

    def create(params)
      @name     = params['name']            if params['name'].present?
      @slug     = params['slug']            if params['slug'].present?
      @units    = params['units']           if params['units'].present?
      @status   = params['status']          if params['status'].present?
      @descri   = params['description']     if params['description'].present?
      @data     = params['data']            if params['data'].present?
      @data_atr = params['data_attributes'] if params['data_attributes'].present?

      url  = URI.decode('#{ENV['API_URL']}/summary/new')
      params = { connector: {
                 name: @name, data: Oj.load(@data), data_columns: Oj.load(@data_atr),
                 status: @status, description: @descri, slug: @slug, units: @units }
               }

      @c = Curl::Easy.http_post(URI.escape(url), Oj.dump(params)) do |curl|
        curl.headers['Accept']       = 'application/json'
        curl.headers['Content-Type'] = 'application/json'
        curl.username                = ENV['ACCESS_USER']
        curl.password                = ENV['ACCESS_PASSWORD']
      end

      clear_redis_cache('datasets')
    end

    def clear_redis_cache(namespace)
      keys = $redis.keys "#{namespace}"
      $redis.del(*keys) unless keys.empty?
    end
  end
end
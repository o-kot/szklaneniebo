# lib/middleware/upload_size_limiter.rb
module Middleware
  class UploadSizeLimiter
    def initialize(app, limit)
      @app = app
      @limit = limit
    end

    def call(env)
      request = Rack::Request.new(env)
      if request.content_length.to_i > @limit
        return [413, { 'Content-Type' => 'text/plain' }, ['Payload Too Large']]
      end
      @app.call(env)
    end
  end
end

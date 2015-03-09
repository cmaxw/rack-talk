require 'rubygems'
require 'rack'

run Proc.new { |env| ['404', {'Content-Type' => 'text/html'}, ['Sorry, can\'t find your stuff']] }

def get(path, &block)
  app = Class.new do
    @path = path
    @block = block

    class << self
      attr_reader :path, :block
    end

    def initialize(app)
      @app = app
    end

    def path
      self.class.path
    end

    def block
      self.class.block
    end

    def request
      Rack::Request.new(@env)
    end

    def params
      request.params
    end

    def call(env)
      @env = env
      if request.request_method == 'GET' && request.path_info == path
        instance_eval(&block)
      else
        @app.call(env)
      end
    end
  end
  use app
end

get '/' do
  ['200', {'Content-Type' => 'text/html'}, ["#{params}"]]
end

get '/fart' do
  ['200', {'Content-Type' => 'text/html'}, ["#{request.request_method}"]]
end

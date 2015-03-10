class SinatraRoute
  class << self
    attr_reader :request_method, :path, :block
  end

  def initialize(app)
    @app = app
  end

  def path
    request.path_info
  end

  def request_method
    request.request_method
  end

  def _path
    self.class.path
  end

  def _block
    self.class.block
  end

  def _request_method
    self.class.request_method
  end

  def request
    Rack::Request.new(@env)
  end

  def params
    request.params
  end

  def erb(filename)
    file = File.new(File.expand_path("../../views/#{filename}.erb", __FILE__))
    ERB.new(file.read).result binding
  end

  def call(env)
    @env = env
    if request_method == _request_method && path == _path
      ['200', {'Content-Type' => "text/html"}, [instance_eval(&_block).to_s]]
    else
      @app.call(env)
    end
  end
end

def SinatraRoute(request_method, path, block)
  Class.new(SinatraRoute) do
    @request_method = request_method
    @path = path
    @block = block
  end
end

def get(path, &block)
  use SinatraRoute('GET', path, block)
end

def post(path, &block)
  use SinatraRoute('POST', path, block)
end

def put(path, &block)
  use SinatraRoute('PUT', path, block)
end

def patch(path, &block)
  use SinatraRoute('PATCH', path, block)
end

def delete(path, &block)
  use SinatraRoute('DELETE', path, block)
end

def options(path, &block)
  use SinatraRoute('OPTIONS', path, block)
end

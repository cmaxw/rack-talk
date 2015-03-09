require 'rubygems'
require 'rack'
require_relative 'lib/sinatra_route'

get '/' do
  ['200', {'Content-Type' => 'text/html'}, ["#{params}"]]
end

get '/fart' do
  ['200', {'Content-Type' => 'text/html'}, ["#{request.request_method}"]]
end

run Proc.new { |env| ['404', {'Content-Type' => 'text/html'}, ['Sorry, can\'t find your stuff']] }

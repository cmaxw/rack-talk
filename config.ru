require 'rubygems'
require 'rack'
require_relative 'lib/sinatra_route'

get '/' do
  params
end

get '/fart' do
  request_method
end

get '/school' do
  @gold = "1110"
  erb 'school'
end

run Proc.new { |env| ['404', {'Content-Type' => 'text/html'}, ['Sorry, can\'t find your stuff']] }

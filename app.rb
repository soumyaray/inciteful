require 'sinatra/base'
require 'citesight'
require 'haml'

class IncitefulApp < Sinatra::Base
  use Rack::Session::Pool, :expire_after => 2592000

  configure :development, :production do
    enable :logging
  end

  get '/' do
    haml :index
  end

  post '/text' do
  end
end

require 'sinatra/base'
require 'citesight'
require 'haml'

class IncitefulApp < Sinatra::Base
  use Rack::Session::Pool, :expire_after => 2592000

  configure :development, :production do
    enable :logging
  end

  get '/' do
    haml :entry
  end

  post '/text' do
    contents = params[:manuscript]
    @cites =  PaperCitations.unique_cites(contents)
    @top_cite = get_first_cite sorted_decreasing(@cites)
    @top_cite_indexes = PaperCitations.index_of_cite(contents, @top_cite)

    haml :results
  end

  def helper_cites_haml

  end

  def sorted_decreasing(cites)
    cites.sort_by { |_c, count| count}.reverse
  end

  def get_first_cite(cites)
    cites.first[0]
  end
end

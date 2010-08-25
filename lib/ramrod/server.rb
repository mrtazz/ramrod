begin
  require 'sinatra/base'
  require 'mustache/sinatra'
  require 'sass'
rescue LoadError
  require 'rubygems'
  require 'sinatra/base'
  require 'mustache/sinatra'
  require 'sass'
end

class Ramrod

  class Server < Sinatra::Base
    register Mustache::Sinatra

    base = File.dirname(__FILE__)

    set :logging, :true
    set :root, base
    set :public, "#{base}/static"
    require base + "/views/layout"

    set :mustache, {
      :views     => "#{base}/views/",
      :templates => "#{base}/templates/",
      :namespace => Ramrod
    }

    # index page
    get '/' do
      mustache :index
    end




    # css
    get '/css/style.css' do
      content_type 'text/css', :charset => 'utf-8'
      sass :stylesheet
    end

  end
end

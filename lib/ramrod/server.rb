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

    # get project page
    get '/projects/:project/?' do
      p = Ramrod::Data::Project.first(:project => params[:project].to_s)
      if p
        mustache :projectindex
      else
        404
      end
    end

    # new project form
    get '/projects/new/?' do
      @actionurl = "/projects/create"
      mustache :projectindex
    end

    # create new project with given parameters
    post '/projects/create/?' do
      p = Ramrod::Data::Project.new
    end

    # css
    get '/css/style.css' do
      content_type 'text/css', :charset => 'utf-8'
      sass :stylesheet
    end

  end
end

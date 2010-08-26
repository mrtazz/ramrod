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

require 'lib/ramrod/data'

class Ramrod

  class Server < Sinatra::Base
    register Mustache::Sinatra
    include Ramrod::Data

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
      @projects = Project.all
      mustache :index
    end

    # new project form
    get '/projects/new/?' do
      @actionurl = "/projects/create"
      mustache :projectindex
    end

    # create new project with given parameters
    post '/projects/create/?' do
      p = Project.new
    end

    # get project page
    get '/projects/:project/?' do
      p = Project.first(:name => params[:project].to_s)
      if p
        mustache :projectindex
      else
        404
      end
    end

    # edit project settings
    get '/projects/:project/edit' do
      p = Project.first(:name => params[:project].to_s)
      if p
        # TODO: mustache :projectindex
      else
        404
      end
    end


    # tell ramrod to build
    post '/projects/:project/build/?' do
      p = Project.first(:name => params[:project].to_s)
      if p
        # TODO: notify agents here
      else
        404
      end
    end

    # notification for build results
    put '/projects/:project/notify/?' do
      p = Project.first(:name => params[:project].to_s)
      if p
        # TODO: set build result for project
      else
        404
      end
    end


    # css
    get '/css/style.css' do
      content_type 'text/css', :charset => 'utf-8'
      sass :stylesheet
    end

  end
end

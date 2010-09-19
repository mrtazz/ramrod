begin
require "bundler/setup"
rescue LoadError
  require 'rubygems'
  require "bundler/setup"
end
require 'sinatra/base'
require 'mustache/sinatra'
require 'sass'
require 'json'
require 'net/http'
require 'uri'

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
      mustache :projectindex
    end

    # create new project with given parameters
    post '/projects/new/?' do
      p = Project.new
      p.name = params[:projectname]
      p.description = params[:description]
      p.token = params[:token]
      p.url = params[:projecturl]
      p.save
      redirect "/projects/#{params[:projectname]}"
    end

    # get project page
    get '/projects/:project/?' do
      p = Project.first(:name => params[:project].to_s)
      if p
        @actionurl = "/projects/#{params[:project]}"
        @project = p
        @agentlist = p.agents.all
        mustache :projectindex
      else
        404
      end
    end

    # edit project settings
    post '/projects/:project/?' do
      p = Project.first(:name => params[:project].to_s)
      if p
        p.update(:name => params[:projectname],
                 :description => params[:description],
                 :token => params[:token],
                 :url => params[:projecturl])
        redirect "/projects/#{params[:projectname]}"
      else
        404
      end
    end

    # get agents objects as json
    get '/projects/:project/agents/?' do
      p = Project.first(:name => params[:project].to_s)
      if p
        agents = p.agents
        #json agents
      else
        404
      end
    end

    # get form for new agent
    get '/projects/:project/agents/new/?' do
      p = Project.first(:name => params[:project].to_s)
      if p
        # TODO return form for creating new agent
      else
        404
      end
    end

    # create new agent
    post '/projects/:project/agents/new/?' do
      p = Project.first(:name => params[:project].to_s)
      if p
        # TODO create agent for the designated project
        a = Agent.create(
          :project_id => p.id,
          :name => params[:agentname],
          :description => params[:description],
          :url => params[:agenturl]
        )
        redirect "/projects/#{p.name}"
      else
        404
      end
    end

    # delete agent
    delete '/projects/:project/agents/:agentname/?' do
      p = Project.first(:name => params[:project].to_s)
      if p
        a = p.agents.first(:name => params[:agentname].to_s)
        a.destroy
        200
      else
        404
      end
    end

    # tell ramrod to build
    post '/projects/:project/build/?' do
      p = Project.first(:name => params[:project].to_s)
      if p
        p.agents.each do |a|
          url = URI.parse(a.url)
          path = url.path.length > 0 ? url.path : "/"
          port = url.port ||= 80
          req = Net::HTTP::Post.new(path)
          net = Net::HTTP.new(url.host, port)
          begin
            net.start {|http| http.request(req)}
          rescue
            a.update(:status => "Unable to connect.")
          end
        end
        200
      else
        404
      end
    end

    # notification for build results
    put '/projects/:project/notify/?' do
      p = Project.first(:name => params[:project].to_s)
      token = params["token"]
      success = params["success"]
      name = params["name"]
      if p # if project exists
        if p.token == token # if correct token was supplied
          p.agents.each do |a|
            if a.name == name
              a.update(:success => success)
              status = (success == "true" ? "Build succeeded." : "Build failed.")
              a.update(:status => status)
            end
          end
          200
        else
          403
        end
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

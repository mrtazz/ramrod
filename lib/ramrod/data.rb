begin
  require 'dm-core'
rescue LoadError
  require 'rubygems'
  require 'rake'
end


class Ramrod
  module Data

    Datamapper.setup(:default, ENV['DATABASE_URL'] ||
                     "sqlite3://#{Dir.pwd}/db/db.sqlite")

    class Project
      include DataMapper::Resource

      property :id, Serial
      property :name, String
      property :description, String
      property :token, String
      property :url, String

      has n, :agents

    end

    class Agent
      include DataMapper::Resource

      property :id, Serial
      property :name, String
      property :description, String
      property :url, String
      property :callback, String
      property :success, Boolean

      belongs_to :project

    end

    DataMapper.auto_upgrade!

  end
end

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

    end

    class Agent
      include DataMapper::Resource

      property :id, Serial
      property :name, String
      property :callback, String
      property :success, Boolean

    end

    DataMapper.auto_upgrade!

  end
end

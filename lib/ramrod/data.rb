require 'dm-core'
require 'dm-migrations'


class Ramrod
  module Data

    DataMapper.setup(:default, ENV['DATABASE_URL'] ||
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
      property :success, Boolean, :default => false
      property :status, String

      belongs_to :project

    end

    DataMapper.finalize

    DataMapper.auto_upgrade!

  end
end

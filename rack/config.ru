require 'json'
require 'mysql2'

module Rack
  class ServerStatus
    def call(env)
      req = Request.new(env)
      response_hash = {}
      begin
        dbconfig = {:adapter => "mysql2", :encoding => "utf8", :reconnect => true, :database => "app", :username => "user", :password => "password", :host => "db"}
        connection = Mysql2::Client.new(dbconfig)
        connection.query('SELECT version();')
        response_hash[:mysql] = "running"
      rescue Exception => e
        response_hash[:mysql] = "down"
      end

      response = Response.new
      response.write(response_hash.to_json)
      response.finish
    end
  end
end

if $0 == __FILE__
  require 'rack'
  require 'rack/showexceptions'
  Rack::Handler::WEBrick.run \
    Rack::ShowExceptions.new(Rack::Lint.new(Rack::ServerStatus.new)),
    :Port => 9292
end

run Rack::ServerStatus.new
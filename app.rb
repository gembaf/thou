require 'sinatra'
require 'sinatra/asset_pipeline'
require 'sinatra-websocket'
require 'sinatra/reloader' if development?

require 'slim'
require 'sass'
require 'coffee-script'

Dir[File.dirname(__FILE__) + '/models/**/*.rb'].each { |f| require f }

set :root, File.dirname(__FILE__)
set :assets_precompile, %w(application.js application.css
                           *.png *.jpg *.svg
                           *.eot *.ttf *.woff)
set :assets_css_compressor, :sass
set :assets_js_compressor, :uglifier
register Sinatra::AssetPipeline

set :server, 'thin'
set :sockets, []
set :game, Game.new

get '/' do
  slim :index
end

get '/websocket' do
  if request.websocket?
    request.websocket do |ws|
      ws.onopen do
        settings.sockets << ws
      end

      ws.onmessage do |data|
        settings.game.add_user data
        settings.sockets.each do |s|
          s.send(settings.game.to_hash.to_json)
        end
      end

      ws.onclose do
        settings.sockets.delete(ws)
      end
    end
  end
end

get '/data' do
  settings.game = Game.new if settings.sockets.empty?
  settings.game.to_hash.to_json
end


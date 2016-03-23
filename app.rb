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
set :game, Game.new

get '/' do
  slim :index
end

get '/websocket' do
  if request.websocket?
    request.websocket do |ws|
      ws.onopen do
        settings.game.add_client(ws)
      end

      ws.onmessage do |data|
        data = JSON.parse data, symbolize_names: true
        settings.game.update(ws, data[:command], data[:current_user])
        settings.game.send_all
      end

      ws.onclose do
        settings.game.remove_client(ws)
        settings.game = Game.new unless settings.game.exist_clients?
      end
    end
  end
end


Game = require './game.coffee'

ReactDOM.render(
  <Game ws={new WebSocket("ws://#{window.location.host}/websocket")} />,
  document.getElementById('game')
)

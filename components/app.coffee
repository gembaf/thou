Game = require './game.coffee'

ReactDOM.render(
  <Game source="http://#{window.location.host}/data" />,
  document.getElementById('game')
)

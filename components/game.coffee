UserList = require './user_list.coffee'
LoginForm = require './login_form.coffee'

Game = React.createClass
  mixins: [React.addons.LinkedStateMixin]

  ws: new WebSocket('ws://' + window.location.host + '/websocket')

  propTypes:
    source: React.PropTypes.string.isRequired

  getInitialState: ->
    data:
      users: []
    is_login: false

  componentDidMount: ->
    @getUserData()
    @ws.onmessage = (m) =>
      @setState data: JSON.parse m.data

  getUserData: ->
    $.getJSON @props.source, (data) =>
      @setState data: data

  handleLogin: ->
    @is_login = true

  render: ->
    <div className="game">
      <div className="row">
        {
          if !@is_login
            <div className="col-xs-12">
              <LoginForm ws={@ws} handleLogin={@handleLogin} />
            </div>
        }
        <UserList users={@state.data["users"]} />
        {
          if @is_login
            <div className="col-xs-12">
              <button className="btn btn-success">Game Start</button>
            </div>
        }
      </div>
    </div>

module.exports = Game


CommandConstants = require './command_constants.coffee'

UserList = require './user_list.coffee'
LoginForm = require './login_form.coffee'

Game = React.createClass
  mixins: [React.addons.LinkedStateMixin]

  propTypes:
    ws: React.PropTypes.object.isRequired

  getInitialState: ->
    data:
      users: []
    current_user: {}
    is_login: false

  componentWillMount: ->
    @props.ws.onopen = =>
      id = Math.random().toString(36).slice(-8)
      @setState current_user: {id: id}
      @sendCurrentUserData(CommandConstants.ADD_CLIENT)
    @props.ws.onmessage = (m) =>
      @setState data: JSON.parse m.data

  handleLogin: (name) ->
    @is_login = true
    @state.current_user["name"] = name
    @setState current_user: @state.current_user
    @sendCurrentUserData(CommandConstants.SIGN_IN)

  sendCurrentUserData: (cmd) ->
    @props.ws.send JSON.stringify(command: cmd, current_user: @state.current_user)

  render: ->
    <div className="game">
      <div className="row">
        {
          if !@is_login
            <div className="col-xs-12">
              <LoginForm handleLogin={@handleLogin} />
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


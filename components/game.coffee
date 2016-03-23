CommandConstants = require './command_constants.coffee'

UserList = require './user_list.coffee'
LoginForm = require './login_form.coffee'
Thou = require './thou.coffee'

Game = React.createClass
  propTypes:
    ws: React.PropTypes.object.isRequired

  getInitialState: ->
    game:
      users: []
      status: ""
      max_vote: ""
    current_user: {}
    is_login: false

  componentWillMount: ->
    @props.ws.onopen = =>
      id = Math.random().toString(36).slice(-8)
      @setState current_user: {id: id}
      @sendCurrentUserData(CommandConstants.ADD_CLIENT)
    @props.ws.onmessage = (m) =>
      @setState game: JSON.parse m.data

  handleLogin: (name) ->
    @setState is_login: true
    @state.current_user["name"] = name
    @setState current_user: @state.current_user
    @sendCurrentUserData(CommandConstants.SIGN_IN)

  handleStart: ->
    @sendCurrentUserData(CommandConstants.GAME_START)

  handleVote: (id) ->
    @state.current_user["vote_id"] = id
    @setState current_user: @state.current_user
    @sendCurrentUserData("VOTE")

  sendCurrentUserData: (cmd) ->
    @props.ws.send JSON.stringify(command: cmd, current_user: @state.current_user)

  render: ->
    <div className="game">
      <div className="row">
        <div className="col-xs-12">
          <UserList users={@state.game["users"]} />
          {
            switch @state.game["status"]
              when "GAME"
                <Thou users={@state.game["users"]} handleVote={@handleVote} maxVote={@state.game["users"].filter (user) => user["id"] == @state.game["max_vote"]} />
              else # SIGN_IN
                if @state.is_login
                  <button className="btn btn-success" onClick={@handleStart}>Game Start</button>
                else
                  <LoginForm handleLogin={@handleLogin} />
          }
        </div>
      </div>
    </div>

module.exports = Game


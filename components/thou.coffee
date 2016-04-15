Thou = React.createClass
  propTypes:
    users: React.PropTypes.arrayOf(
      React.PropTypes.shape
        id: React.PropTypes.string.isRequired
        name: React.PropTypes.string.isRequired
    )
    handleVote: React.PropTypes.func.isRequired

  handleVote: (id) ->
    @props.handleVote(id)

  render: ->
    users = @props.users.map (user) =>
      <button key={"vote-list-" + user["id"]} className="btn" onClick={@handleVote.bind(@, user["id"])}>{user["name"]}</button>

    <div className="thou">
      <p>ゲーム画面</p>
      {users}
      <div>
        {
          if @props.maxVote[0]
            "vote " + @props.maxVote[0]["name"]
        }
      </div>
    </div>

module.exports = Thou


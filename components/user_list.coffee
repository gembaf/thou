UserList = React.createClass
  propTypes:
    users: React.PropTypes.arrayOf(
      React.PropTypes.shape
        id: React.PropTypes.string.isRequired
        name: React.PropTypes.string.isRequired
    )

  render: ->
    users = @props.users.map (user) ->
      <li key={"user-" + user["id"]}>{user["name"]}</li>

    <div className="user_list">
      <ul>{users}</ul>
    </div>

module.exports = UserList


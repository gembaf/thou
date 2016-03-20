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
      <div className="row">
        <div className="col-xs-12">
          <ul>{users}</ul>
        </div>
      </div>
    </div>

module.exports = UserList


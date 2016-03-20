LoginForm = React.createClass
  mixins: [React.addons.LinkedStateMixin]

  propTypes:
    handleLogin: React.PropTypes.func.isRequired

  getInitialState: ->
    name: ""

  onClick: (e) ->
    @props.handleLogin(@state.name)

  render: ->
    <div className="login_form">
      <div className="row">
        <div className="col-xs-6">
          <input id="name" className="form-control" type="text" valueLink={@linkState 'name'} placeholder="ユーザ名" />
        </div>
        <div className="col-xs-6">
          <button className="btn btn-primary" onClick={@onClick}>submit</button>
        </div>
      </div>
    </div>

module.exports = LoginForm


LoginForm = React.createClass
  mixins: [React.addons.LinkedStateMixin]

  propTypes:
    ws: React.PropTypes.object.isRequired
    handleLogin: React.PropTypes.func.isRequired

  getInitialState: ->
    name: ""

  onClick: (e) ->
    @props.ws.send(@state.name)
    @props.handleLogin()

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


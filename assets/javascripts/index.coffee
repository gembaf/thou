$ ->
  ws = new WebSocket('ws://' + window.location.host + '/websocket')

  $.ajax
    type: 'GET'
    url: 'http://' + window.location.host + '/messages'
    dataType: 'json'
    success: (data) ->
      data.forEach (val, i) ->
        li = '<li>' + val + '</li>'
        $('ul#user_list').append(li)

  ws.onmessage = (m) ->
    li = '<li>' + m.data + '</li>'
    $('ul#user_list').append(li)

  $('button#add_user').click ->
    ws.send($('input#name').val())
    $('input#name').val("")
    $('#input_name').hide()
    $('#game_start').show()


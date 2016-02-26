$ ->
  ws = new WebSocket('ws://' + window.location.host + '/websocket')

  $.ajax
    type: 'GET'
    url: 'http://' + window.location.host + '/messages'
    dataType: 'json'
    success: (data) ->
      data.forEach (val, i) ->
        li = '<li>' + val + '</li>'
        $('ul#name_list').append(li)

  ws.onmessage = (m) ->
    li = '<li>' + m.data + '</li>'
    $('ul#name_list').append(li)

  $('button').click ->
    ws.send($('input#name').val())
    $('input#name').val("")


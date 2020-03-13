App.book = App.cable.subscriptions.create "BookChannel",
  connected: ->
     console.log "connected, huraaaaaaaaaaaaaaaaaaa!"
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->   
    val = parseInt($('meta[name=current-user]').attr('id'), 10)
    val2 = parseInt(data.entity.user_id, 10)
    alert(val == val2)
       
    #unless @userIsCurrentUser(data.entity.user_id)
    $('#messages').append data['message']  unless val == val2
    # Called when there's incoming data on the websocket for this channel

  speak: (message) ->
    @perform 'speak', message: message


$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode is 13 # return = send
    App.book.speak event.target.value
    event.target.value = ''
    event.preventDefault()


userIsCurrentUser: (publisher_user_id) ->
    alert("userIsCurrentUser")
    val = parseInt($('meta[name=current-user]').attr('id'), 10)
    val2 = parseInt(publisher_user_id, 10)
    return val == val2

    
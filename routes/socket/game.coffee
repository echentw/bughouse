io = null
database = null

join = (data) ->
  socket = this

  gameID = data.gameID
  username = data.username

  if socket.handshake.session.gameID != gameID
    return

  game = database.find(gameID)
  if !game
    return

  socket.join(gameID)
  game.connectSocket(username)

  message = username + ' joined game ' + gameID
  seats = game.getSeats()
  io.sockets.in(gameID).emit('update', {message: message, seats: seats})

  console.log message

disconnect = ->
  socket = this
  session = socket.handshake.session

  game = database.find(session.gameID)
  if !game
    return

  game.setTimeout(session.username)
  setTimeout( ->
    game = database.find(session.gameID)
    if !game
      return
    if !game.findUser(session.username)
      message = session.username + ' left game ' + session.gameID
      io.sockets.in(session.gameID).emit('update', {message: message})
      console.log message

      if game.empty()
        database.delete(session.gameID)
  , 2000)

module.exports.attach = (socketIO, db) ->
  database = db
  io = socketIO

  io.sockets.on('connection', (socket) ->
    socket.on('join', join)
    socket.on('disconnect', disconnect)
  )

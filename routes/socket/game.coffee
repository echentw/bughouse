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
  io.sockets.in(gameID).emit('update', {message: message})
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
        database.delete(gameID)
  , 2000)

hit = (data) ->
  socket = this
  session = socket.handshake.session

  if session.gameID != data.gameID ||
      session.username != data.username
    return

  message = session.username + ' pinged game ' + session.gameID
  io.sockets.in(session.gameID).emit('update', {message: message})
  console.log message

module.exports.attach = (socketIO, db) ->
  database = db
  io = socketIO

  io.sockets.on('connection', (socket) ->
    socket.on('join', join)
    socket.on('disconnect', disconnect)
    socket.on('hit', hit)
  )

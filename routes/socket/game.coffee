io = null
database = null

move = (data) ->
  socket = this
  session = socket.handshake.session

  gameID = data.gameID
  username = data.username

  if session.gameID != gameID ||
      session.username != username
    return

  game = database.find(gameID)
  if !game
    return

  success = game.move(data.move)
  if !success
    return

  # TODO: finish implementing this
  io.sockets.in(gameID).emit('move')

module.exports.attach = (socketIO, db) ->
  database = db
  io = socketIO

  io.sockets.on('connection', (socket) ->
    socket.on('move', move)
  )

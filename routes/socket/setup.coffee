io = null
database = null

sit = (data) ->
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

  seatNum = Math.floor(Number(data.seatNum))
  if isNaN(seatNum) || seatNum < 1 || seatNum > 4
    return

  result = game.seatUser(username, seatNum)
  if !result.success
    return

  io.sockets.in(gameID).emit('seated', {seats: result.seats})

module.exports.attach = (socketIO, db) ->
  database = db
  io = socketIO

  io.sockets.on('connection', (socket) ->
    socket.on('sit', sit)
  )

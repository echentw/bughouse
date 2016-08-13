define(['socket-io'], (io) ->

  class Client
    constructor: (gameID, username) ->
      @gameID = gameID
      @username = username
      @socket = getSocket()
      @socket.emit('join', {gameID: gameID, username: username})

    ping: =>
      @socket.emit('hit', {gameID: @gameID, username: @username})

    sit: (seatNum) =>
      @socket.emit('sit', {gameID: @gameID, username: @username, seatNum: seatNum})

    getSocket = ->
      socket = io.connect()
      socket.on('update', (data) ->
        console.log data.message
        updateSeats(data.seats)
      )
      socket.on('error', (data) ->
        console.log data.message
      )
      socket.on('seated', (data) ->
        updateSeats(data.seats)
      )
      return socket

    updateSeats = (seats) ->
      for seatNum of seats
        id = '#seat' + seatNum
        $(id).text(seats[seatNum])

  return Client
)

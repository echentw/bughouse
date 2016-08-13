Player = require('./bughouse/helpers/player')
Bughouse = require('./bughouse/bughouse')

class Game
  constructor: ->
    @users = {}
    @disconnectedUsers = {}
    @players = {
      1: null,
      2: null,
      3: null,
      4: null
    }
    @bughouse = null

  findUser: (username) =>
    return username of @users

  addUser: (username) =>
    if username of @users
      return false
    @users[username] = true
    return true

  seatUser: (username, seatNum) =>
    if @players[seatNum] != null
      @players[seatNum] = username
    for i in [1...5]
      if @players[seatNum] == null
        return
    @startGame()

  startGame: =>
    @players[1] = new Player(1, 0) # team 1, white
    @players[2] = new Player(1, 1) # team 1, black
    @players[3] = new Player(2, 1) # team 2, black
    @players[4] = new Player(2, 0) # team 2, white
    @bughouse = new Bughouse(@players[1], @players[2], @players[3], @players[4])

  removeUser: (username) =>
    if username of @users
      delete @users[username]
      if username of @disconnectedUsers
        delete @disconnectedUsers[username]
      return true
    return false

  # maintain a more stable connection
  # remove the user from the game after 1.5 seconds,
  # if user has not reconnected within that time
  setTimeout: (username) =>
    if username of @users
      @disconnectedUsers[username] = true
      setTimeout( =>
        if @disconnectedUsers[username]
          @removeUser(username)
      , 1500)

  # maintain a more stable connection
  # add the user back in if the user reconnects within 1.5 seconds
  connectSocket: (username) =>
    if username of @users
      if username of @disconnectedUsers
        delete @disconnectedUsers[username]

  empty: ->
    return Object.keys(@users).length == 0

module.exports = Game

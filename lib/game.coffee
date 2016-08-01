class Channel
  constructor: ->
    @users = {}
    @disconnectedUsers = {}

  findUser: (username) =>
    return username of @users

  addUser: (username) =>
    if username of @users
      return false
    @users[username] = true
    return true

  removeUser: (username) =>
    if username of @users
      delete @users[username]
      if username of @disconnectedUsers
        delete @disconnectedUsers[username]
      return true
    return false

  # maintain a more stable connection
  # remove the user from the channel after 1.5 seconds,
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

module.exports = Channel

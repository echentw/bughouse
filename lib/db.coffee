Game = require('./Game')

class GameDB
  constructor: ->
    @games = {}

  add: (game) =>
    key = generateUniqueGameKey(8)
    @games[key] = new Game()

  find: (key) =>
    if key of @games
      return @games[key]
    return null

  remove: (key) =>
    if key of @games
      delete @games[key]

  generateUniqueGameKey: (keyLength) =>
    chars = '1234567890qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM'
    for i in [0 ... keyLength]
      key += chars[Math.floor(Math.random() * chars.length)]

    while key of @games
      for i in [0 ... keyLength]
        key += chars[Math.floor(Math.random() * chars.length)]

    return key
  
module.exports = GameDB

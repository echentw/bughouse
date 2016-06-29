Constants = require('./helpers/constants')

class Player
  constructor: (id, clock) ->
    @id = id
    @clock = clock
    @canCastle = {
      Constants.KINGSIDE: true
      Constants.QUEENSIDE: true
    }

module.exports = Player

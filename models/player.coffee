Constants = require('./helpers/constants')

class Player
  constructor: (id, clock) ->
    @id = id
    @clock = clock
    @canCastle = initCastlePrivileges()

  # PRIVATE

  initCastlePrivileges = ->
    canCastle = {}
    canCastle[Constants.KINGSIDE] = true
    canCastle[Constants.QUEENSIDE] = true
    return canCastle

module.exports = Player

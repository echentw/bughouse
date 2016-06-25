_ = require('lodash')

Constants = require('../helpers/constants')
Square = require('../helpers/square')

class King
  VALID_MOVES = [
    [-1, -1], [-1, 0], [-1, 1],
    [0, -1], [0, 1],
    [1, -1], [1, 0], [1, 1]
  ]

  constructor: ->

  # assumes that the squares respect the board boundaries
  @moveValid: (board, fromRow, fromCol, toRow, toCol) ->
    fromStatus = Square.getStatus(board, fromRow, fromCol)
    toStatus = Square.getStatus(board, toRow, toCol)

    # check if a friendly piece is occupying the destination
    if toStatus == fromStatus
      return false

    # check if the move is within the king's range
    diffRow = toRow - fromRow
    diffCol = toCol - fromCol
    index = _.findIndex(VALID_MOVES, (move) ->
      move[0] == diffRow && move[1] == diffCol
    )

    if index == -1
      return false

    return true

module.exports = King

_ = require('lodash')

Piece = require('./piece')
Constants = require('../helpers/constants')
Square = require('../helpers/square')

class King extends Piece

  VALID_TO_SQUARES = [
    [-1, -1], [-1, 0], [-1, 1],
    [0, -1], [0, 1],
    [1, -1], [1, 0], [1, 1]
  ]

  @moveValid: (board, move, prevMove) ->
    if @isDrop(move)
      return @dropValid(board, move)

    # unpack the move
    fromRow = move.fromRow
    fromCol = move.fromCol
    toRow = move.toRow
    toCol = move.toCol

    fromStatus = Square.getStatus(board, fromRow, fromCol)
    toStatus = Square.getStatus(board, toRow, toCol)

    # check if a friendly piece is occupying the destination
    if toStatus == fromStatus
      return false

    # check if the move is within the king's range
    diffRow = toRow - fromRow
    diffCol = toCol - fromCol
    index = _.findIndex(VALID_TO_SQUARES, (move) ->
      move[0] == diffRow && move[1] == diffCol
    )

    if index == -1
      return false

    return true

module.exports = King

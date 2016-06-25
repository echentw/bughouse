Constants = require('../helpers/constants')
Square = require('../helpers/square')

class Bishop
  constructor: ->

  # assumes that the squares respect the board boundaries
  @moveValid: (board, fromRow, fromCol, toRow, toCol) ->

    # check that the move is diagonal
    if Math.abs(toRow - fromRow) != Math.abs(toCol - fromCol)
      return false

    fromStatus = Square.getStatus(board, fromRow, fromCol)
    toStatus = Square.getStatus(board, toRow, toCol)

    # check whether a friendly piece is occupying the destination.
    # also checks whether destination square is the same as the current square
    if toStatus == fromStatus
      return false

    # the horizontal and vertical directions of the destination square
    # relative to the current square
    #   left: -1, right: 1
    #   up: -1, down: 1
    vDir = Math.abs(toRow - fromRow) // (toRow - fromRow)
    hDir = Math.abs(toCol - fromCol) // (toCol - fromCol)

    # check that no pieces are between the destination and the current square
    square = [fromRow + vDir, fromCol + hDir]
    while square[0] != toRow
      if Square.getStatus(board, square[0], square[1]) != Constants.NO_PIECE
        return false
      square[0] + vDir
      square[1] + hDir

    return true

module.exports = Bishop

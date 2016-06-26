Constants = require('../helpers/constants')
Square = require('../helpers/square')

class Rook
  constructor: ->

  # assumes that the squares respect the board boundaries
  @moveValid: (board, fromRow, fromCol, toRow, toCol) ->
    fromStatus = Square.getStatus(board, fromRow, fromCol)
    toStatus = Square.getStatus(board, toRow, toCol)

    # check whether a friendly piece is occupying the destination
    # also checks whether destination square is the same as the current square
    if toStatus == fromStatus
      return false

    # at least one of the rows and columns must be the same as the original
    if toRow != fromRow && toCol != fromCol
      return false

    vertical = (toCol == fromCol)

    # vertical move
    if vertical

      # get the direction of movement
      if toRow == fromRow
        return false
      direction = Math.abs(toRow - fromRow) // (toRow - fromRow)

      # check that no piece is between the destination and current square
      row = fromRow + direction
      while row != toRow
        if Square.getStatus(board, row, toCol) != Constants.NO_PIECE
          return false
        row += direction

      return true

    # horizontal move
    else

      # get the direction of movement
      if toCol == fromCol
        return false
      direction = Math.abs(toCol - fromCol) // (toCol - fromCol)

      # check that no piece is between the destination and current square
      col = fromCol + direction
      while col != toCol
        if Square.getStatus(board, toRow, col) != Constants.NO_PIECE
          return false
        col += direction

      return true

module.exports = Rook

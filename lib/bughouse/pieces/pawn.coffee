Piece = require('./piece')
Constants = require('../helpers/constants')
Square = require('../helpers/square')

class Pawn extends Piece
  constructor: ->

  @moveValid: (board, move, prevMove) ->
    super(board, move, prevMove)

    # unpack the move
    fromRow = move.fromRow
    fromCol = move.fromCol
    toRow = move.toRow
    toCol = move.toCol

    fromStatus = Square.getStatus(board, fromRow, fromCol)
    toStatus = Square.getStatus(board, toRow, toCol)

    direction = switch
      when (fromStatus == Constants.WHITE_PIECE) then Constants.UP
      else Constants.DOWN

    # not capturing a piece
    if fromCol == toCol &&
        (toRow == fromRow + 1 * direction || toRow == fromRow + 2 * direction)
      if toStatus != Constants.NO_PIECE
        return false

      # first move of the pawn can move two steps
      if toRow == fromRow + 2 * direction
        initialRow = switch fromStatus
          when Constants.WHITE_PIECE then Constants.BOARD_SIZE - 2
          else 1
        if fromRow == initialRow
          return Square.getStatus(board, fromRow + direction, toCol) ==
            Constants.NO_PIECE
        return false

      return true

    # capturing enemy piece
    if (toCol == fromCol + 1 || toCol == fromCol - 1) &&
        toRow == fromRow + 1 * direction
      # normal capture
      if toStatus != Constants.NO_PIECE && toStatus != fromStatus
        return true

      # en passant
      enPassantSquareStatus = Square.getStatus(board, fromRow, toCol)

      # check that the piece to be captured is an enemy pawn
      if fromStatus == Constants.WHITE_PIECE
        if board.get(fromRow, toCol) != Constants.B_PAWN
          return false
      else
        if board.get(fromRow, toCol) != Constants.W_PAWN
          return false

      # check that the previous move was a pawn push
      if prevMove.toCol != prevMove.fromCol ||
          prevMove.toRow != prevMove.fromRow - 2 * direction
        return false

      # make sure that the to-square is clear
      if toStatus != Constants.NO_PIECE
        return false

      return true

    return false

module.exports = Pawn

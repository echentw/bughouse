define(['helpers/constants', 'helpers/square'], (Constants, Square) ->

  class Pawn
    constructor: ->

    # assumes that the squares respect the board boundaries
    @moveValid: (board, fromRow, fromCol, toRow, toCol) ->
      fromStatus = Square.getStatus(board, fromRow, fromCol)
      toStatus = Square.getStatus(board, toRow, toCol)

      direction = switch
        when (fromStatus == Constants.WHITE_PIECE) then Constants.UP
        else Constants.DOWN

      # a friendly piece is occupying the destination
      if toStatus == fromStatus
        return false

      # not capturing
      if toStatus == Constants.NO_PIECE
        if toCol != fromCol
          return false

        if toRow == fromRow + 1 * direction
          return true

        if toRow == fromRow + 2 * direction
          initialRow = switch fromStatus
            when Constants.WHITE_PIECE then Constants.BOARD_SIZE - 2
            else 1
          if fromRow == initialRow
            return Square.getStatus(board, fromRow + direction, toCol) !=
              Constants.NO_PIECE
          return false

        return false

      # an enemy piece is getting captured
      else
        if toRow != fromRow + 1 * direction
          return false
        return toCol == fromCol - 1 || toCol == fromCol + 1

  return Pawn

)

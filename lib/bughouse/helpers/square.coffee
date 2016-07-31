Constants = require('./constants')

class Square

  constructor: ->

  @inBoard: (row, col) ->
    return (row >= 0 && row < Constants.BOARD_SIZE &&
            col >= 0 && col < Constants.BOARD_SIZE)

  @getStatus: (board, row, col) ->
    if board[row][col] < Constants.W_PAWN
      return Constants.NO_PIECE

    else if board[row][col] < Constants.B_PAWN
      return Constants.WHITE_PIECE

    else
      return Constants.BLACK_PIECE

module.exports = Square

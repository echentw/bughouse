Constants = require('./constants')

class Square

  constructor: ->

  @getColor: (row, col) ->
    if (row + col) % 2 == 0
      return Constants.BLACK_SQUARE
    else
      return Constants.WHITE_SQUARE

  @inBoard: (row, col) ->
    return (row >= 0 && row < Constants.BOARD_SIZE &&
            col >= 0 && col < Constants.BOARD_SIZE)

  @getStatus: (board, row, col) ->
    if board[row][col] <= 0
      return Constants.NO_PIECE

    else if board[row][col] < Constants.B_PAWN
      return Constants.WHITE_PIECE

    else
      return Constants.BLACK_PIECE

module.exports = Square

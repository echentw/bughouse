Constants = require('./constants')

class Square

  # Returns true iff (row, col) is within the bounds of the chessboard.
  #
  # @param {Number} row
  # @param {Number} col
  # @return {Boolean}
  @inBoard: (row, col) ->
    return (row >= 0 && row < Constants.BOARD_SIZE &&
            col >= 0 && col < Constants.BOARD_SIZE)

  # Returns whether the square (row, col) is empty, occupied by a black piece,
  #   or occupied by a white piece.
  #
  # @param {Board} board
  # @param {Number} row
  # @param {Number} col
  @getStatus: (board, row, col) ->
    if board.get(row, col) < Constants.W_PAWN
      return Constants.NO_PIECE

    else if board.get(row, col) < Constants.B_PAWN
      return Constants.WHITE_PIECE

    else
      return Constants.BLACK_PIECE

module.exports = Square

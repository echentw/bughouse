# A class to encapsulate move legality logic for a particular chess piece.

Constants = require('../helpers/constants')
Square = require('../helpers/square')

class Piece

  # Returns true iff the move is valid.
  # Assumes that the moves respect the board boundaries.
  #
  # @param {Board} board
  # @param {Move} move The current move.
  # @param {Move} prevMove The move that was made the previous turn.
  # @return {Boolean}
  @moveValid: (board, move, prevMove) ->
    throw new Error('Subclasses must implement this method.')

  # Returns true iff the drop move is valid.
  # Assumes that the move is a drop move.
  #
  # @param {Board} board
  # @param {Move} move
  # @return {Boolean}
  @dropValid: (board, move) ->
    return Square.getStatus(board, move.toRow, move.toCol) ==
        Constants.NO_PIECE

  # Returns true iff the move is a drop move.
  #
  # @param {Move} move
  # @return {Boolean}
  @isDrop: (move) ->
    return move.fromRow == -1

module.exports = Piece

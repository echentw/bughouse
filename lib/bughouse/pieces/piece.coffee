# A class to encapsulate move legality logic for a particular chess piece.

Constants = require('../helpers/constants')
Square = require('../helpers/square')

class Piece
  constructor: ->

  # Returns true iff the move is valid.
  # Assumes that the moves respect the board boundaries.
  #
  # This parent method only checks that if a piece is dropped on the board,
  # then that square must be empty.
  #
  # @param {Board} board
  # @param {Move} move The current move.
  # @param {Move} prevMove The move that was mad the turn before.
  # @return {Boolean}
  @moveValid: (board, move, prevMove) ->
    if move.fromRow == -1
      return Square.getStatus(board, move.toRow, move.toCol) ==
          Constants.NO_PIECE
    return true

module.exports = Piece

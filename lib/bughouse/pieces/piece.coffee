# A class to encapsulate move legality logic for a particular chess piece.

class Piece
  constructor: ->

  # Returns true iff the move is valid.
  # Assumes that the moves respect the board boundaries.
  #
  # @param {Board} board
  # @param {Move} move The current move.
  # @param {Move} prevMove The move that was mad the turn before.
  # @return {Boolean}
  @moveValid: (board, move, prevMove) ->
    throw new Error('Subclasses must implement this method.')

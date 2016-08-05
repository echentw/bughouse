Constants = require('./constants')

class Player
  this.WHITE = 0
  this.BLACK = 1

  # @param {Number} teamID
  # @param {Number} color If white then 0, if black then 1
  constructor: (teamID, color) ->
    @teamID = teamID
    @color = color
    @canCastle = {
      Constants.KINGSIDE: true,
      Constants.QUEENSIDE: true
    }

    # uses white pieces to represent all the pieces
    @reservePieces = {
      Constants.W_PAWN: 0,
      Constants.W_KNIGHT: 0,
      Constants.W_BISHOP: 0,
      Constants.W_ROOK: 0,
      Constants.W_QUEEN: 0,
      Constants.W_KING: 0
    }

  updateCastlePrivilege: (move) =>
    fromRow = move.fromRow
    fromCol = move.fromCol

    if @color == this.WHITE
      if fromRow == Constants.BOARD_SIZE - 1
        updateCastleHelper(move.fromCol)
    else
      if fromRow == 0
        updateCastleHelper(move.fromCol)

  updateCastleHelper: (col) =>
    if col == 4
      @canCastle[Constants.QUEENSIDE] = false
      @canCastle[Constants.KINGSIDE] = false
    else if col == 0
      @canCastle[Constants.QUEENSIDE] = false
    else if col == Constants.BOARD_SIZE - 1
      @canCastle[Constants.KINGSIDE] = false

module.exports = Player

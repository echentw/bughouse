Constants = require('./constants')

class Player
  this.WHITE = 0
  this.BLACK = 1

  # @param {Number} teamID
  # @param {Number} color If white then 0, if black then 1
  constructor: (teamID, color) ->
    @teamID = teamID
    @color = color

    @canCastle = {}
    @canCastle[Constants.KINGSIDE] = true
    @canCastle[Constants.QUEENSIDE] = true

    # uses white pieces to represent all the pieces
    @reservePieces = {}
    @reservePieces[Constants.PAWN] = 0
    @reservePieces[Constants.KNIGHT] = 0
    @reservePieces[Constants.BISHOP] = 0
    @reservePieces[Constants.ROOK] = 0
    @reservePieces[Constants.QUEEN] = 0

  # Remove a piece from the serve.
  # Returns true iff operation was successful.
  #
  # @param {Number} piece
  # @return {Boolean}
  useReserve: (piece) =>
    if @reservePieces[piece] < 1
      return false
    @reservePieces[piece] -= 1
    return true

  # Add a piece to the reserve.
  #
  # @param {Number} piece
  addReserve: (piece) =>
    @reservePieces[piece] += 1

  # Sets whether the player can castle after the move.
  #
  # @param {Move} move
  updateCastlePrivilege: (move) =>
    fromRow = move.fromRow
    fromCol = move.fromCol

    if @color == this.WHITE
      if fromRow == Constants.BOARD_SIZE - 1
        updateCastleHelper(move.fromCol)
    else
      if fromRow == 0
        updateCastleHelper(move.fromCol)

  # Helper method for updateCastlePrivilege.
  #
  # @param {Number} col The column that the piece is being moved from.
  updateCastleHelper: (col) =>
    if col == 4
      @canCastle[Constants.QUEENSIDE] = false
      @canCastle[Constants.KINGSIDE] = false
    else if col == 0
      @canCastle[Constants.QUEENSIDE] = false
    else if col == Constants.BOARD_SIZE - 1
      @canCastle[Constants.KINGSIDE] = false

module.exports = Player

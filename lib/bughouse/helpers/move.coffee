class Move

  # @param {Number} piece The color-blind piece.
  # @param {Number} fromRow
  # @param {Number} fromCol
  # @param {Number} toRow
  # @param {Number} toCol
  constructor: (piece, fromRow, fromCol, toRow, toCol) ->
    @piece = piece
    @fromRow = fromRow
    @fromCol = fromCol
    @toRow = toRow
    @toCol = toCol

module.exports = Move

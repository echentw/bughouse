class Move

  # @param {Number} fromRow
  # @param {Number} fromCol
  # @param {Number} toRow
  # @param {Number} toCol
  constructor: (fromRow, fromCol, toRow, toCol) ->
    @fromRow = fromRow
    @fromCol = fromCol
    @toRow = toRow
    @toCol = toCol

module.exports = Move

Constants = require('../helpers/constants')
Square = require('../helpers/square')

Bishop = require('./bishop')
Rook = require('./rook')

class Queen
  constructor: ->

  # assumes that the squares respect the board boundaries
  @moveValid: (board, fromRow, fromCol, toRow, toCol) ->

    # a queen behaves like a bishop or a rook on a given turn
    return Bishop.moveValid(board, fromRow, fromCol, toRow, toCol) ||
      Rook.moveValid(board, fromRow, fromCol, toRow, toCol)

module.exports = Queen

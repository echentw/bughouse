Constants = require('../helpers/constants')
Square = require('../helpers/square')

Piece = require('./piece')
Bishop = require('./bishop')
Rook = require('./rook')

class Queen extends Piece
  constructor: ->

  @moveValid: (board, move, prevMove) ->
    if @isDrop(move)
      return @dropValid(board, move)

    # a queen behaves like a bishop or a rook on a given turn
    return Bishop.moveValid(board, move, prevMove) ||
        Rook.moveValid(board, move, prevMove)

module.exports = Queen

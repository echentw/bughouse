_ = require('lodash')

Constants = require('./helpers/constants')
Square = require('./helpers/square')

Pawn = require('./pieces/pawn')
Knight = require('./pieces/knight')
Bishop = require('./pieces/bishop')
Rook = require('./pieces/rook')
Queen = require('./pieces/queen')
King = require('./pieces/king')

class Chess
  constructor: (player1Id, player2Id) ->
    @player1Id = player1Id
    @player2Id = player2Id

    @board = setupBoard()

  setupBoard = ->
    board = []

    board.push([
      Constants.B_ROOK, Constants.B_KNIGHT, Constants.B_BISHOP,
      Constants.B_QUEEN, Constants.B_KING,
      Constants.B_BISHOP, Constants.B_KNIGHT, Constants.B_ROOK
    ])
    board.push((Constants.B_PAWN for i in [0 ... Constants.BOARD_SIZE]))

    for i in [0 ... (Constants.BOARD_SIZE - 4)]
      board.push((Constants.NO_PIECE for i in [0 ... Constants.BOARD_SIZE]))

    board.push((Constants.W_PAWN for i in [0 ... Constants.BOARD_SIZE]))
    board.push([
      Constants.W_ROOK, Constants.W_KNIGHT, Constants.W_BISHOP,
      Constants.W_QUEEN, Constants.W_KING,
      Constants.W_BISHOP, Constants.W_KNIGHT, Constants.W_ROOK
    ])

    return board

module.exports = Chess

Constants = require('./constants')
Square = require('./square')

Pawn = require('../pieces/pawn')
Knight = require('../pieces/knight')
Bishop = require('../pieces/bishop')
Rook = require('../pieces/rook')
Queen = require('../pieces/queen')
King = require('../pieces/king')

class Board
  constructor: ->
    @board = setupBoard()

  # Get the identity of the piece on (row, col).
  # If the square is empty, then returns Constants.NO_PIECE (-1)
  #
  # @param {Number} row
  # @param {Number} col
  # @return {Number}
  get: (row, col) ->
    return @board[row][col]

  # Performs the move on the board.
  # Does no checks.
  #
  # @param {Move} move
  move: (move) ->
    @board[move.toRow][move.toCol] = @board[move.fromRow][move.fromCol]
    @board[move.fromRow][move.fromCol] = Constants.NO_PIECE

  # Sets a piece on the board.
  #
  # @param {Number} row
  # @param {Number} col
  # @param {Number} piece The identity of the piece.
  set: (row, col, piece) ->
    @board[row][col] = piece

  clear: ->
    for row in [0...Constants.BOARD_SIZE]
      for col in [0...Constants.BOARD_SIZE]
        @board[row][col] = Constants.NO_PIECE

  # initialize the board
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

module.exports = Board

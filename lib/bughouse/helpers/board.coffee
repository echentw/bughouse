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
  # Assumes that the move is valid.
  #
  # @param {Move} move
  # @param {Number} moveType The type of the move.
  # @param {Number} promotionChoice
  move: (move, moveType, promotionChoice = null) ->
    @board[move.toRow][move.toCol] = @board[move.fromRow][move.fromCol]
    @board[move.fromRow][move.fromCol] = Constants.NO_PIECE

    if moveType == Constants.PROMOTING_MOVE
      @board[move.toRow][move.toCol] = promotionChoice

    else if moveType == Constants.CASTLING_MOVE
      direction = (move.fromCol - move.toCol) / 2
      rookCol = 0 if direction < 0 else Constants.BOARD_SIZE - 1
      @board[move.toRow][move.toCol - direction] = @board[move.toRow][rookCol]
      @board[move.toRow][move.rookCol] = Constants.NO_PIECE

    else if moveType == Constants.EN_PASSANT_MOVE
      @board[move.fromRow][move.toCol] = Constants.NO_PIECE

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

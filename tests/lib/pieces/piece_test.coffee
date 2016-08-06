chai = require('chai')
chai.should()

_ = require('lodash')

Move = require('../../../lib/bughouse/helpers/move')
Board = require('../../../lib/bughouse/helpers/board')
Constants = require('../../../lib/bughouse/helpers/constants')

Pawn = require('../../../lib/bughouse/pieces/pawn')
Knight = require('../../../lib/bughouse/pieces/knight')
Bishop = require('../../../lib/bughouse/pieces/bishop')
Rook = require('../../../lib/bughouse/pieces/rook')
Queen = require('../../../lib/bughouse/pieces/queen')
King = require('../../../lib/bughouse/pieces/king')

getPieceConstant = (pieceClass) ->
  switch pieceClass
    when Pawn
      return Constants.B_PAWN
    when Knight
      return Constants.W_KNIGHT
    when Bishop
      return Constants.B_BISHOP
    when Rook
      return Constants.W_ROOK
    when Queen
      return Constants.B_QUEEN
    when King
      return Constants.W_KING
    else
      return Constants.NO_PIECE

shouldBehaveLikeAPiece = (pieceClass) ->
  occupiedWhiteSquares = [[2, 2], [4, 4], [5, 7]]
  occupiedBlackSquares = [[1, 1], [3, 3], [4, 6]]
  occupiedSquares = _.concat(occupiedWhiteSquares, occupiedBlackSquares)

  piece = getPieceConstant(pieceClass)

  board = new Board()
  prevMove = new Move(Constants.NO_PIECE, -1, -1, -1, -1)

  beforeEach ->
    board.clear()
    _.forEach(occupiedWhiteSquares, (square) ->
      board.set(square[0], square[1], Constants.W_KNIGHT)
    )
    _.forEach(occupiedBlackSquares, (square) ->
      board.set(square[0], square[1], Constants.B_BISHOP)
    )

  it 'should not be able to drop a piece on occupied squares', ->
    _.forEach(occupiedSquares, (square) ->
      move = new Move(piece, -1, -1, square[0], square[1])
      pieceClass.moveValid(board, move, prevMove).should.equal false
    )

  it 'should be able to drop a piece on an unoccupied squares', ->
    for row in [0...Constants.BOARD_SIZE]
      for col in [0...Constants.BOARD_SIZE]
        index = _.findIndex(occupiedSquares, (square) ->
          return row == square[0] && col == square[1]
        )
        if index == -1
          move = new Move(piece, -1, -1, row, col)
          pieceClass.moveValid(board, move, prevMove).should.equal true

module.exports.shouldBehaveLikeAPiece = shouldBehaveLikeAPiece

chai = require('chai')
chai.should()

_ = require('lodash')

Move = require('../../../lib/bughouse/helpers/move')
Board = require('../../../lib/bughouse/helpers/board')
Constants = require('../../../lib/bughouse/helpers/constants')

shouldBehaveLikeAPiece = (pieceClass) ->
  occupiedWhiteSquares = [[2, 2], [4, 4], [5, 7]]
  occupiedBlackSquares = [[1, 1], [3, 3], [4, 6]]
  occupiedSquares = _.concat(occupiedWhiteSquares, occupiedBlackSquares)

  board = new Board()
  prevMove = new Move(-1, -1, -1, -1)

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
      move = new Move(-1, -1, square[0], square[1])
      pieceClass.moveValid(board, move, prevMove).should.equal false
    )

  it 'should be able to drop a piece on an unoccupied squares', ->
    for row in [0...Constants.BOARD_SIZE]
      for col in [0...Constants.BOARD_SIZE]
        index = _.findIndex(occupiedSquares, (square) ->
          return row == square[0] && col == square[1]
        )
        if index == -1
          move = new Move(-1, -1, row, col)
          pieceClass.moveValid(board, move, prevMove).should.equal true

module.exports.shouldBehaveLikeAPiece = shouldBehaveLikeAPiece

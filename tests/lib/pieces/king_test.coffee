chai = require('chai')
chai.should()

_ = require('lodash')

Move = require('../../../lib/bughouse/helpers/move')
Board = require('../../../lib/bughouse/helpers/board')
Constants = require('../../../lib/bughouse/helpers/constants')
Square = require('../../../lib/bughouse/helpers/square')

King = require('../../../lib/bughouse/pieces/king')

PieceTest = require('./piece_test')

describe 'King', ->
  describe 'moveValid()', ->
    describe 'shared behavior', ->
      PieceTest.shouldBehaveLikeAPiece(King)

    board = new Board()
    prevMove = new Move(Constants.NO_PIECE, -1, -1, -1, -1)

    row = 4
    col = 3

    validToSquares = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1], [0, 1],
      [1, -1], [1, 0], [1, 1]
    ]

    beforeEach ->
      board.clear()
      board.set(row, col, Constants.W_KING)

    describe 'empty board', ->
      it 'can move to valid squares', ->
        for r in [0 ... Constants.BOARD_SIZE]
          for c in [0 ... Constants.BOARD_SIZE]
            move = new Move(Constants.W_KING, row, col, r, c)
            diffRow = r - row
            diffCol = c - col
            index = _.findIndex(validToSquares, (square) ->
              diffRow == square[0] && diffCol == square[1]
            )
            if index != -1
              King.moveValid(board, move, prevMove).should.equal true

      it 'cannot move to invalid squares', ->
        for r in [0 ... Constants.BOARD_SIZE]
          for c in [0 ... Constants.BOARD_SIZE]
            move = new Move(Constants.W_KING, row, col, r, c)
            diffRow = r - row
            diffCol = c - col
            index = _.findIndex(validToSquares, (square) ->
              diffRow == square[0] && diffCol == square[1]
            )
            if index == -1
              King.moveValid(board, move, prevMove).should.equal false

    describe 'friendly pieces in the way', ->
      beforeEach ->
        _.forEach(validToSquares, (square) ->
          board.set(row + square[0], col + square[1], Constants.W_ROOK)
        )

      it 'cannot move to friendly squares', ->
        _.forEach(validToSquares, (square) ->
          move = new Move(
            Constants.W_KING, row, col, row + square[0], col + square[1]
          )
          King.moveValid(board, move, prevMove).should.equal false
        )

    describe 'enemy pieces in the way', ->
      beforeEach ->
        _.forEach(validToSquares, (square) ->
          board.set(row + square[0], col + square[1], Constants.B_ROOK)
        )

      it 'can capture enemy pieces', ->
        _.forEach(validToSquares, (square) ->
          move = new Move(
            Constants.W_KING, row, col, row + square[0], col + square[1]
          )
          King.moveValid(board, move, prevMove).should.equal true
        )

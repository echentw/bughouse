chai = require('chai')
chai.should()

_ = require('lodash')

Board = require('../../../lib/bughouse/helpers/board')
Move = require('../../../lib/bughouse/helpers/move')
Constants = require('../../../lib/bughouse/helpers/constants')
Square = require('../../../lib/bughouse/helpers/square')

Pawn = require('../../../lib/bughouse/pieces/pawn')

PieceTest = require('./piece_test')

describe 'Pawn', ->
  describe 'moveValid()', ->

    board = new Board()
    prevMove = new Move(Constants.NO_PIECE, -1, -1, -1, -1)

    beforeEach ->
      board.clear()

    describe 'never moved', ->
      wRow = Constants.BOARD_SIZE - 2
      wCol = 0

      bRow = 1
      bCol = 0

      beforeEach ->
        board.set(wRow, wCol, Constants.W_PAWN)
        board.set(bRow, bCol, Constants.B_PAWN)

      it 'can move one space forward', ->
        move = new Move(Constants.W_PAWN, wRow, wCol, wRow - 1, wCol)
        Pawn.moveValid(board, move, prevMove).should.equal true

        move = new Move(Constants.B_PAWN, bRow, bCol, bRow + 1, bCol)
        Pawn.moveValid(board, move, prevMove).should.equal true

      it 'can move two spaces forward', ->
        move = new Move(Constants.W_PAWN, wRow, wCol, wRow - 2, wCol)
        Pawn.moveValid(board, move, prevMove).should.equal true

        move = new Move(Constants.B_PAWN, bRow, bCol, bRow + 2, bCol)
        Pawn.moveValid(board, move, prevMove).should.equal true

      it 'cannot move anywhere else', ->
        for row in [0 ... Constants.BOARD_SIZE]
          for col in [0 ... Constants.BOARD_SIZE]
            if (row != wRow - 1 || col != wCol) &&
               (row != wRow - 2 || col != wCol)
              move = new Move(Constants.W_PAWN, wRow, wCol, row, col)
              Pawn.moveValid(board, move, prevMove).should.equal false

            if (row != bRow + 1 || col != bCol) &&
               (row != bRow + 2 || col != bCol)
              move = new Move(Constants.B_PAWN, bRow, bCol, row, col)
              Pawn.moveValid(board, move, prevMove).should.equal false

    describe 'moved already', ->
      row = 4
      col = 4

      it 'can move one space forward', ->
        board.set(row, col, Constants.W_PAWN)
        move = new Move(Constants.W_PAWN, row, col, row - 1, col)
        Pawn.moveValid(board, move, prevMove).should.equal true

        board.set(row, col, Constants.B_PAWN)
        move = new Move(Constants.B_PAWN, row, col, row + 1, col)
        Pawn.moveValid(board, move, prevMove).should.equal true

      it 'cannot move anywhere else', ->
        board.set(row, col, Constants.W_PAWN)
        for r in [0 ... Constants.BOARD_SIZE]
          for c in [0 ... Constants.BOARD_SIZE]
            if r != row - 1 || c != col
              move = new Move(Constants.W_PAWN, row, col, r, c)
              Pawn.moveValid(board, move, prevMove).should.equal false

        board.set(row, col, Constants.B_PAWN)
        for r in [0 ... Constants.BOARD_SIZE]
          for c in [0 ... Constants.BOARD_SIZE]
            if r != row + 1 || c != col
              move = new Move(Constants.B_PAWN, row, col, r, c)
              Pawn.moveValid(board, move, prevMove).should.equal false

    describe 'capturing', ->
      wRow = 6
      wCol = 6
      wCaptures = [[wRow - 1, wCol - 1], [wRow - 1, wCol + 1]]

      bRow = 3
      bCol = 3
      bCaptures = [[bRow + 1, bCol - 1], [bRow + 1, bCol + 1]]

      beforeEach ->
        board.set(wRow, wCol, Constants.W_PAWN)
        board.set(wCaptures[0][0], wCaptures[0][1], Constants.B_KNIGHT)
        board.set(wCaptures[1][0], wCaptures[1][1], Constants.B_KNIGHT)

        board.set(bRow, bCol, Constants.B_PAWN)
        board.set(bCaptures[0][0], bCaptures[0][1], Constants.W_BISHOP)
        board.set(bCaptures[1][0], bCaptures[1][1], Constants.W_BISHOP)

      it 'it can capture pieces', ->
        move = new Move(
          Constants.W_PAWN, wRow, wCol, wCaptures[0][0], wCaptures[0][1]
        )
        Pawn.moveValid(board, move, prevMove).should.equal true

        move = new Move(
          Constants.W_PAWN, wRow, wCol, wCaptures[1][0], wCaptures[1][1]
        )
        Pawn.moveValid(board, move, prevMove).should.equal true

        move = new Move(
          Constants.B_PAWN, bRow, bCol, bCaptures[0][0], bCaptures[0][1]
       )
        Pawn.moveValid(board, move, prevMove).should.equal true

        move = new Move(
          Constants.B_PAWN, bRow, bCol, bCaptures[1][0], bCaptures[1][1]
        )
        Pawn.moveValid(board, move, prevMove).should.equal true

    describe 'obstacles', ->
      wRow = 6
      wCol = 6

      bRow = 3
      bCol = 3

      beforeEach ->
        board.set(wRow, wCol, Constants.W_PAWN)
        board.set(bRow, bCol, Constants.B_PAWN)
        board.set(wRow - 1, wCol, Constants.B_KNIGHT)
        board.set(bRow + 1, bCol, Constants.B_KNIGHT)

      it 'cannot move', ->
        for row in [0 ... Constants.BOARD_SIZE]
          for col in [0 ... Constants.BOARD_SIZE]
            move = new Move(Constants.W_PAWN, wRow, wCol, row, col)
            Pawn.moveValid(board, move, prevMove).should.equal false

            move = new Move(Constants.B_PAWN, bRow, bCol, row, col)
            Pawn.moveValid(board, move, prevMove).should.equal false

    describe 'en passant', ->
      wRow = 3
      wCol = 4

      bRow = wRow
      bCol = wCol - 1

      beforeEach ->
        board.set(wRow, wCol, Constants.W_PAWN)
        board.set(bRow, bCol, Constants.B_PAWN)
        prevMove = new Move(Constants.B_PAWN, bRow - 2, bCol, bRow, bCol)

      it 'can en passant', ->
        move = new Move(Constants.W_PAWN, wRow, wCol, bRow - 1, bCol)
        Pawn.moveValid(board, move, prevMove).should == true

    describe 'drop move', ->
      occupiedWhiteSquares = [[2, 2], [4, 4], [5, 7]]
      occupiedBlackSquares = [[1, 1], [3, 3], [4, 6]]
      occupiedSquares = _.concat(occupiedWhiteSquares, occupiedBlackSquares)

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
          move = new Move(Constants.W_PAWN, -1, -1, square[0], square[1])
          Pawn.moveValid(board, move, prevMove).should.equal false
        )

      it 'should be able to drop a piece on an unoccupied squares', ->
        for row in [1...Constants.BOARD_SIZE - 1]
          for col in [0...Constants.BOARD_SIZE]
            index = _.findIndex(occupiedSquares, (square) ->
              return row == square[0] && col == square[1]
            )
            if index == -1
              move = new Move(Constants.W_PAWN, -1, -1, row, col)
              Pawn.moveValid(board, move, prevMove).should.equal true

      it 'should not be able to drop a piece on the first and last ranks', ->
        for row in [0, Constants.BOARD_SIZE - 1]
          for col in [0...Constants.BOARD_SIZE]
            move = new Move(Constants.W_PAWN, -1, -1, row, col)
            Pawn.moveValid(board, move, prevMove).should.equal false

chai = require('chai')
chai.should()

_ = require('lodash')

Board = require('../../../lib/bughouse/helpers/board')
Move = require('../../../lib/bughouse/helpers/move')
Constants = require('../../../lib/bughouse/helpers/constants')
Square = require('../../../lib/bughouse/helpers/square')

Queen = require('../../../lib/bughouse/pieces/queen')

PieceTest = require('./piece_test')

describe 'Queen', ->
  describe 'moveValid()', ->
    describe 'shared behavior', ->
      PieceTest.shouldBehaveLikeAPiece(Queen)

    board = new Board()
    prevMove = new Move(Constants.NO_PIECE, -1, -1, -1, -1)

    row = 4
    col = 3

    beforeEach ->
      board.clear()
      board.set(row, col, Constants.W_QUEEN)

    describe 'empty board', ->
      it 'can move to valid squares', ->
        for r in [0 ... Constants.BOARD_SIZE]
          for c in [0 ... Constants.BOARD_SIZE]
            if r == row && c == col
              continue

            move = new Move(Constants.W_QUEEN, row, col, r, c)

            if r == row && c != col
              Queen.moveValid(board, move, prevMove).should.equal true

            else if r != row && c == col
              Queen.moveValid(board, move, prevMove).should.equal true

            else if Math.abs(r - row) == Math.abs(c - col)
              Queen.moveValid(board, move, prevMove).should.equal true

      it 'cannot move to invalid squares', ->
        for r in [0 ... Constants.BOARD_SIZE]
          for c in [0 ... Constants.BOARD_SIZE]
            move = new Move(Constants.W_QUEEN, row, col, r, c)

            if r == row && c == col
              Queen.moveValid(board, move, prevMove).should.equal false

            if !(r == row && c != col) && !(r != row && c == col) &&
                Math.abs(r - row) != Math.abs(c - col)
              Queen.moveValid(board, move, prevMove).should.equal false

    describe 'friendly pieces in the way', ->
      d = 2

      beforeEach ->
        # rook moves
        board.set(row + d, col, Constants.W_ROOK)
        board.set(row - d, col, Constants.W_ROOK)
        board.set(row, col + d, Constants.W_ROOK)
        board.set(row, col - d, Constants.W_ROOK)

        # bishop moves
        board.set(row + d, col + d, Constants.W_ROOK)
        board.set(row + d, col - d, Constants.W_ROOK)
        board.set(row - d, col + d, Constants.W_ROOK)
        board.set(row - d, col - d, Constants.W_ROOK)

      it 'cannot move to friendly squares', ->
        rookMoves = [
          new Move(Constants.W_QUEEN, row, col, row + d, col),
          new Move(Constants.W_QUEEN, row, col, row - d, col),
          new Move(Constants.W_QUEEN, row, col, row, col + d),
          new Move(Constants.W_QUEEN, row, col, row, col - d)
        ]
        bishopMoves = [
          new Move(Constants.W_QUEEN, row, col, row + d, col + d),
          new Move(Constants.W_QUEEN, row, col, row + d, col - d),
          new Move(Constants.W_QUEEN, row, col, row - d, col + d),
          new Move(Constants.W_QUEEN, row, col, row - d, col - d)
        ]

        _.forEach(rookMoves, (move) ->
          Queen.moveValid(board, move, prevMove).should.equal false
        )
        _.forEach(bishopMoves, (move) ->
          Queen.moveValid(board, move, prevMove).should.equal false
        )

      it 'can move up to friendly squares', ->
        rookMoves = [
          new Move(Constants.W_QUEEN, row, col, row + d - 1, col),
          new Move(Constants.W_QUEEN, row, col, row - d + 1, col),
          new Move(Constants.W_QUEEN, row, col, row, col + d - 1),
          new Move(Constants.W_QUEEN, row, col, row, col - d + 1)
        ]
        bishopMoves = [
          new Move(Constants.W_QUEEN, row, col, row + d - 1, col + d - 1),
          new Move(Constants.W_QUEEN, row, col, row + d - 1, col - d + 1),
          new Move(Constants.W_QUEEN, row, col, row - d + 1, col + d - 1),
          new Move(Constants.W_QUEEN, row, col, row - d + 1, col - d + 1)
        ]

        _.forEach(rookMoves, (move) ->
          Queen.moveValid(board, move, prevMove).should.equal true
        )
        _.forEach(bishopMoves, (move) ->
          Queen.moveValid(board, move, prevMove).should.equal true
        )

      it 'cannot move past friendly squares', ->
        rookMoves = [
          new Move(Constants.W_QUEEN, row, col, row + d + 1, col),
          new Move(Constants.W_QUEEN, row, col, row - d - 1, col),
          new Move(Constants.W_QUEEN, row, col, row, col + d + 1),
          new Move(Constants.W_QUEEN, row, col, row, col - d - 1)
        ]
        bishopMoves = [
          new Move(Constants.W_QUEEN, row, col, row + d + 1, col + d + 1),
          new Move(Constants.W_QUEEN, row, col, row + d + 1, col - d - 1),
          new Move(Constants.W_QUEEN, row, col, row - d - 1, col + d + 1),
          new Move(Constants.W_QUEEN, row, col, row - d - 1, col - d - 1)
        ]

        _.forEach(rookMoves, (move) ->
          Queen.moveValid(board, move, prevMove).should.equal false
        )
        _.forEach(bishopMoves, (move) ->
          Queen.moveValid(board, move, prevMove).should.equal false
        )

    describe 'enemy pieces in the way', ->
      d = 2

      beforeEach ->
        # rook moves
        board.set(row + d, col, Constants.B_ROOK)
        board.set(row - d, col, Constants.B_ROOK)
        board.set(row, col + d, Constants.B_ROOK)
        board.set(row, col - d, Constants.B_ROOK)

        # bishop moves
        board.set(row + d, col + d, Constants.B_ROOK)
        board.set(row + d, col - d, Constants.B_ROOK)
        board.set(row - d, col + d, Constants.B_ROOK)
        board.set(row - d, col - d, Constants.B_ROOK)

      it 'can capture enemy pieces', ->
        rookMoves = [
          new Move(Constants.W_QUEEN, row, col, row + d, col),
          new Move(Constants.W_QUEEN, row, col, row - d, col),
          new Move(Constants.W_QUEEN, row, col, row, col + d),
          new Move(Constants.W_QUEEN, row, col, row, col - d)
        ]
        bishopMoves = [
          new Move(Constants.W_QUEEN, row, col, row + d, col + d),
          new Move(Constants.W_QUEEN, row, col, row + d, col - d),
          new Move(Constants.W_QUEEN, row, col, row - d, col + d),
          new Move(Constants.W_QUEEN, row, col, row - d, col - d)
        ]
        _.forEach(rookMoves, (move) ->
          Queen.moveValid(board, move, prevMove).should.equal true
        )
        _.forEach(bishopMoves, (move) ->
          Queen.moveValid(board, move, prevMove).should.equal true
        )

      it 'can move up to enemy pieces', ->
        rookMoves = [
          new Move(Constants.W_QUEEN, row, col, row + d - 1, col),
          new Move(Constants.W_QUEEN, row, col, row - d + 1, col),
          new Move(Constants.W_QUEEN, row, col, row, col + d - 1),
          new Move(Constants.W_QUEEN, row, col, row, col - d + 1)
        ]
        bishopMoves = [
          new Move(Constants.W_QUEEN, row, col, row + d - 1, col + d - 1),
          new Move(Constants.W_QUEEN, row, col, row + d - 1, col - d + 1),
          new Move(Constants.W_QUEEN, row, col, row - d + 1, col + d - 1),
          new Move(Constants.W_QUEEN, row, col, row - d + 1, col - d + 1)
        ]

        _.forEach(rookMoves, (move) ->
          Queen.moveValid(board, move, prevMove).should.equal true
        )
        _.forEach(bishopMoves, (move) ->
          Queen.moveValid(board, move, prevMove).should.equal true
        )

      it 'cannot move past enemy pieces', ->
        rookMoves = [
          new Move(Constants.W_QUEEN, row, col, row + d + 1, col),
          new Move(Constants.W_QUEEN, row, col, row - d - 1, col),
          new Move(Constants.W_QUEEN, row, col, row, col + d + 1),
          new Move(Constants.W_QUEEN, row, col, row, col - d - 1)
        ]
        bishopMoves = [
          new Move(Constants.W_QUEEN, row, col, row + d + 1, col + d + 1),
          new Move(Constants.W_QUEEN, row, col, row + d + 1, col - d - 1),
          new Move(Constants.W_QUEEN, row, col, row - d - 1, col + d + 1),
          new Move(Constants.W_QUEEN, row, col, row - d - 1, col - d - 1)
        ]

        _.forEach(rookMoves, (move) ->
          Queen.moveValid(board, move, prevMove).should.equal false
        )
        _.forEach(bishopMoves, (move) ->
          Queen.moveValid(board, move, prevMove).should.equal false
        )

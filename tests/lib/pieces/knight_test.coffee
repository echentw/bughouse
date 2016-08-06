chai = require('chai')
chai.should()

_ = require('lodash')

Board = require('../../../lib/bughouse/helpers/board')
Move = require('../../../lib/bughouse/helpers/move')
Constants = require('../../../lib/bughouse/helpers/constants')
Square = require('../../../lib/bughouse/helpers/square')

Knight = require('../../../lib/bughouse/pieces/knight')

PieceTest = require('./piece_test')

describe 'Knight', ->
  describe 'moveValid()', ->
    describe 'shared behavior', ->
      PieceTest.shouldBehaveLikeAPiece(Knight)

    board = new Board()
    prevMove = new Move(Constants.NO_PIECE, -1, -1, -1, -1)

    row = 4
    col = 4

    validMoves = [
      [1, 2], [1, -2], [-1, 2], [-1, -2],
      [2, 1], [2, -1], [-2, 1], [-2, -1]
    ]

    captureIndices = [2, 4]
    friendlyIndices = [3, 6]

    beforeEach ->
      board.clear()

    describe 'valid potential moves', ->
      beforeEach ->
        board.set(row, col, Constants.W_KNIGHT)
        for i in captureIndices
          board.set(row + validMoves[i][0], col + validMoves[i][1], Constants.B_PAWN)
        for i in friendlyIndices
          board.set(row + validMoves[i][0], col + validMoves[i][1], Constants.W_PAWN)

      it 'can move to any nonfriendly square', ->
        for vMove, i in validMoves
          if _.indexOf(friendlyIndices, i) == -1
            move = new Move(
              Constants.W_KNIGHT, row, col, row + vMove[0], col + vMove[1]
            )
            Knight.moveValid(board, move, prevMove).should.equal true

      it 'cannot move to any square with a piece of the same color', ->
        for vMove, i in validMoves
          if _.indexOf(friendlyIndices, i) != -1
            move = new Move(
              Constants.W_KNIGHT, row, col, row + vMove[0], col + vMove[1]
            )
            Knight.moveValid(board, move, prevMove).should.equal false

    describe 'invalid potential moves', ->
      it 'cannot move to any invalid square', ->
        for r in [0 ... Constants.BOARD_SIZE]
          for c in [0 ... Constants.BOARD_SIZE]
            move = new Move(Constants.W_KNIGHT, row, col, r, c)
            index = _.findIndex(validMoves, (vMove) ->
              (vMove[0] == r - row) && (vMove[1] == c - col)
            )
            if index == -1
              Knight.moveValid(board, move, prevMove).should.equal false

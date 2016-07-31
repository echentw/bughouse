chai = require('chai')
chai.should()

_ = require('lodash')

Constants = require('../../../lib/bughouse/helpers/constants')
Square = require('../../../lib/bughouse/helpers/square')
King = require('../../../lib/bughouse/pieces/king')

describe 'King', ->
  describe 'moveValid()', ->
    board = null

    row = 4
    col = 3

    validMoves = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1], [0, 1],
      [1, -1], [1, 0], [1, 1]
    ]

    beforeEach ->
      board = ((Constants.NO_PIECE for i in [0 ... Constants.BOARD_SIZE]) \
                                   for j in [0 ... Constants.BOARD_SIZE])
      board[row][col] = Constants.W_KING

    describe 'empty board', ->
      it 'can move to valid squares', ->
        for r in [0 ... Constants.BOARD_SIZE]
          for c in [0 ... Constants.BOARD_SIZE]
            diffRow = r - row
            diffCol = c - col
            index = _.findIndex(validMoves, (move) ->
              diffRow == move[0] && diffCol == move[1]
            )
            if index != -1
              King.moveValid(board, row, col, r, c).should.equal true

      it 'cannot move to invalid squares', ->
        for r in [0 ... Constants.BOARD_SIZE]
          for c in [0 ... Constants.BOARD_SIZE]
            diffRow = r - row
            diffCol = c - col
            index = _.findIndex(validMoves, (move) ->
              diffRow == move[0] && diffCol == move[1]
            )
            if index == -1
              King.moveValid(board, row, col, r, c).should.equal false

    describe 'friendly pieces in the way', ->
      beforeEach ->
        _.forEach(validMoves, (move) ->
          board[row + move[0]][col + move[1]] = Constants.W_ROOK
        )

      it 'cannot move to friendly squares', ->
        _.forEach(validMoves, (move) ->
          King.moveValid(board, row, col, row + move[0], col + move[1])
            .should.equal false
        )

    describe 'enemy pieces in the way', ->
      beforeEach ->
        _.forEach(validMoves, (move) ->
          board[row + move[0]][col + move[1]] = Constants.B_ROOK
        )

      it 'can capture enemy pieces', ->
        _.forEach(validMoves, (move) ->
          King.moveValid(board, row, col, row + move[0], col + move[1])
            .should.equal true
        )

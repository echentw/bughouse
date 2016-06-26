chai = require('chai')
chai.should()

_ = require('lodash')

Constants = require('../../../models/helpers/constants')
Square = require('../../../models/helpers/square')
Knight = require('../../../models/pieces/knight')

describe 'Knight', ->
  describe 'moveValid()', ->
    board = null

    row = 4
    col = 4

    validMoves = [[1, 2], [1, -2], [-1, 2], [-1, -2],
                  [2, 1], [2, -1], [-2, 1], [-2, -1]]

    captureIndices = [2, 4]
    friendlyIndices = [3, 6]

    beforeEach ->
      board = ((Constants.NO_PIECE for i in [0 ... Constants.BOARD_SIZE]) \
                                   for j in [0 ... Constants.BOARD_SIZE])

    describe 'valid potential moves', ->
      beforeEach ->
        board[row][col] = Constants.W_KNIGHT
        for i in captureIndices
          board[row + validMoves[i][0]][col + validMoves[i][1]] =
            Constants.B_PAWN
        for i in friendlyIndices
          board[row + validMoves[i][0]][col + validMoves[i][1]] =
            Constants.W_PAWN

      it 'can move to any nonfriendly square', ->
        for move, i in validMoves
          if _.indexOf(friendlyIndices, i) == -1
            Knight.moveValid(board, row, col, row + move[0], col + move[1])
              .should.equal true

      it 'cannot move to any square with a piece of the same color', ->
        for move, i in validMoves
          if _.indexOf(friendlyIndices, i) != -1
            Knight.moveValid(board, row, col, row + move[0], col + move[1])
              .should.equal false


      it 'cannot move to any invalid square', ->
        for r in [0 ... Constants.BOARD_SIZE]
          for c in [0 ... Constants.BOARD_SIZE]
            diffRow = r - row
            diffCol = c - col
            index = _.findIndex(validMoves, (move) ->
              move[0] == diffRow && move[1] == diffCol
            )
            if index == -1
              Knight.moveValid(board, row, col, r, c).should.equal false

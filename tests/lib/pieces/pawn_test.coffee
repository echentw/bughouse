chai = require('chai')
chai.should()

Constants = require('../../../lib/bughouse/helpers/constants')
Square = require('../../../lib/bughouse/helpers/square')
Pawn = require('../../../lib/bughouse/pieces/pawn')

describe 'Pawn', ->
  describe 'moveValid()', ->
    board = null

    beforeEach ->
      board = ((Constants.NO_PIECE for i in [0 ... Constants.BOARD_SIZE]) \
                                   for j in [0 ... Constants.BOARD_SIZE])

    describe 'never moved', ->
      wRow = Constants.BOARD_SIZE - 2
      wCol = 0

      bRow = 1
      bCol = 0

      beforeEach ->
        board[wRow][wCol] = Constants.W_PAWN
        board[bRow][bCol] = Constants.B_PAWN

      it 'can move one space forward', ->
        Pawn.moveValid(board, wRow, wCol, wRow - 1, wCol).should.equal true
        Pawn.moveValid(board, bRow, bCol, bRow + 1, bCol).should.equal true

      it 'can move two spaces forward', ->
        Pawn.moveValid(board, wRow, wCol, wRow - 2, wCol).should.equal true
        Pawn.moveValid(board, bRow, bCol, bRow + 2, bCol).should.equal true

      it 'cannot move anywhere else', ->
        for row in [0 ... Constants.BOARD_SIZE]
          for col in [0 ... Constants.BOARD_SIZE]
            if (row != wRow - 1 || col != wCol) &&
               (row != wRow - 2 || col != wCol)
              Pawn.moveValid(board, wRow, wCol, row, col).should.equal false

            if (row != bRow + 1 || col != bCol) &&
               (row != bRow + 2 || col != bCol)
              Pawn.moveValid(board, bRow, bCol, row, col).should.equal false

    describe 'moved already', ->
      row = 4
      col = 4

      it 'can move one space forward', ->
        board[row][col] = Constants.W_PAWN
        Pawn.moveValid(board, row, col, row - 1, col).should.equal true

        board[row][col] = Constants.B_PAWN
        Pawn.moveValid(board, row, col, row + 1, col).should.equal true

      it 'cannot move anywhere else', ->
        board[row][col] = Constants.W_PAWN
        for r in [0 ... Constants.BOARD_SIZE]
          for c in [0 ... Constants.BOARD_SIZE]
            if r != row - 1 || c != col
              Pawn.moveValid(board, row, col, r, c).should.equal false

        board[row][col] = Constants.B_PAWN
        for r in [0 ... Constants.BOARD_SIZE]
          for c in [0 ... Constants.BOARD_SIZE]
            if r != row + 1 || c != col
              Pawn.moveValid(board, row, col, r, c).should.equal false

    describe 'capturing', ->
      wRow = 6
      wCol = 6
      wCaptures = [[wRow - 1, wCol - 1], [wRow - 1, wCol + 1]]

      bRow = 3
      bCol = 3
      bCaptures = [[bRow + 1, bCol - 1], [bRow + 1, bCol + 1]]

      beforeEach ->
        board[wRow][wCol] = Constants.W_PAWN
        board[ wCaptures[0][0] ][ wCaptures[0][1] ] = Constants.B_KNIGHT
        board[ wCaptures[1][0] ][ wCaptures[1][1] ] = Constants.B_KNIGHT

        board[bRow][bCol] = Constants.B_PAWN
        board[ bCaptures[0][0] ][ bCaptures[0][1] ] = Constants.W_BISHOP
        board[ bCaptures[1][0] ][ bCaptures[1][1] ] = Constants.W_BISHOP

      it 'it can capture pieces', ->
        Pawn.moveValid(board, wRow, wCol, wCaptures[0][0], wCaptures[0][1])
          .should.equal true

        Pawn.moveValid(board, wRow, wCol, wCaptures[1][0], wCaptures[1][1])
          .should.equal true

        Pawn.moveValid(board, bRow, bCol, bCaptures[0][0], bCaptures[0][1])
          .should.equal true

        Pawn.moveValid(board, bRow, bCol, bCaptures[1][0], bCaptures[1][1])
          .should.equal true

    describe 'obstacles', ->
      wRow = 6
      wCol = 6

      bRow = 3
      bCol = 3

      beforeEach ->
        board[wRow - 1][wCol] = Constants.B_KNIGHT
        board[bRow + 1][wCol] = Constants.B_KNIGHT

      it 'cannot move', ->
        for row in [0 ... Constants.BOARD_SIZE]
          for col in [0 ... Constants.BOARD_SIZE]
            Pawn.moveValid(board, wRow, wCol, row, col).should.equal false
            Pawn.moveValid(board, bRow, bCol, row, col).should.equal false

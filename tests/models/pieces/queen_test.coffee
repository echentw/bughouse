chai = require('chai')
chai.should()

Constants = require('../../../models/helpers/constants')
Square = require('../../../models/helpers/square')
Queen = require('../../../models/pieces/queen')

describe 'Queen', ->
  describe 'moveValid()', ->
    board = null

    row = 4
    col = 3

    beforeEach ->
      board = ((Constants.NO_PIECE for i in [0 ... Constants.BOARD_SIZE]) \
                                   for j in [0 ... Constants.BOARD_SIZE])
      board[row][col] = Constants.W_QUEEN

    describe 'empty board', ->
      it 'can move to valid squares', ->
        for r in [0 ... Constants.BOARD_SIZE]
          for c in [0 ... Constants.BOARD_SIZE]
            if r == row && c == col
              continue

            if r == row && c != col
              Queen.moveValid(board, row, col, r, c).should.equal true

            else if r != row && c == col
              Queen.moveValid(board, row, col, r, c).should.equal true

            else if Math.abs(r - row) == Math.abs(c - col)
              Queen.moveValid(board, row, col, r, c).should.equal true

      it 'cannot move to invalid squares', ->
        for r in [0 ... Constants.BOARD_SIZE]
          for c in [0 ... Constants.BOARD_SIZE]
            if r == row && c == col
              Queen.moveValid(board, row, col, r, c).should.equal false

            if !(r == row && c != col) && !(r != row && c == col) &&
               Math.abs(r - row) != Math.abs(c - col)
              Queen.moveValid(board, row, col, r, c).should.equal false

    describe 'friendly pieces in the way', ->
      d = 2

      beforeEach ->
        # rook moves
        board[row + d][col] = Constants.W_ROOK
        board[row - d][col] = Constants.W_ROOK
        board[row][col + d] = Constants.W_ROOK
        board[row][col - d] = Constants.W_ROOK

        # bishop moves
        board[row + d][col + d] = Constants.W_ROOK
        board[row + d][col - d] = Constants.W_ROOK
        board[row - d][col + d] = Constants.W_ROOK
        board[row - d][col - d] = Constants.W_ROOK

      it 'cannot move to friendly squares', ->
        Queen.moveValid(board, row, col, row + d, col).should.equal false
        Queen.moveValid(board, row, col, row - d, col).should.equal false
        Queen.moveValid(board, row, col, row, col + d).should.equal false
        Queen.moveValid(board, row, col, row, col - d).should.equal false

        Queen.moveValid(board, row, col, row + d, col + d).should.equal false
        Queen.moveValid(board, row, col, row + d, col - d).should.equal false
        Queen.moveValid(board, row, col, row - d, col + d).should.equal false
        Queen.moveValid(board, row, col, row - d, col - d).should.equal false

      it 'can move up to friendly squares', ->
        Queen.moveValid(board, row, col, row + d - 1, col).should.equal true
        Queen.moveValid(board, row, col, row - d + 1, col).should.equal true
        Queen.moveValid(board, row, col, row, col + d - 1).should.equal true
        Queen.moveValid(board, row, col, row, col - d + 1).should.equal true

        Queen.moveValid(board, row, col, row + d - 1, col + d - 1)
          .should.equal true
        Queen.moveValid(board, row, col, row + d - 1, col - d + 1)
          .should.equal true
        Queen.moveValid(board, row, col, row - d + 1, col + d - 1)
          .should.equal true
        Queen.moveValid(board, row, col, row - d + 1, col - d + 1)
          .should.equal true

      it 'cannot move past friendly squares', ->
        Queen.moveValid(board, row, col, row + d + 1, col).should.equal false
        Queen.moveValid(board, row, col, row - d - 1, col).should.equal false
        Queen.moveValid(board, row, col, row, col + d + 1).should.equal false
        Queen.moveValid(board, row, col, row, col - d - 1).should.equal false

        Queen.moveValid(board, row, col, row + d + 1, col + d + 1)
          .should.equal false
        Queen.moveValid(board, row, col, row + d + 1, col - d - 1)
          .should.equal false
        Queen.moveValid(board, row, col, row - d - 1, col + d + 1)
          .should.equal false
        Queen.moveValid(board, row, col, row - d - 1, col - d - 1)
          .should.equal false

    describe 'enemy pieces in the way', ->
      d = 2

      beforeEach ->
        # rook moves
        board[row + d][col] = Constants.B_ROOK
        board[row - d][col] = Constants.B_ROOK
        board[row][col + d] = Constants.B_ROOK
        board[row][col - d] = Constants.B_ROOK

        # bishop moves
        board[row + d][col + d] = Constants.B_ROOK
        board[row + d][col - d] = Constants.B_ROOK
        board[row - d][col + d] = Constants.B_ROOK
        board[row - d][col - d] = Constants.B_ROOK

      it 'can capture enemy pieces', ->
        Queen.moveValid(board, row, col, row + d, col).should.equal true
        Queen.moveValid(board, row, col, row - d, col).should.equal true
        Queen.moveValid(board, row, col, row, col + d).should.equal true
        Queen.moveValid(board, row, col, row, col - d).should.equal true

        Queen.moveValid(board, row, col, row + d, col + d).should.equal true
        Queen.moveValid(board, row, col, row + d, col - d).should.equal true
        Queen.moveValid(board, row, col, row - d, col + d).should.equal true
        Queen.moveValid(board, row, col, row - d, col - d).should.equal true

      it 'can move up to enemy pieces', ->
        Queen.moveValid(board, row, col, row + d - 1, col).should.equal true
        Queen.moveValid(board, row, col, row - d + 1, col).should.equal true
        Queen.moveValid(board, row, col, row, col + d - 1).should.equal true
        Queen.moveValid(board, row, col, row, col - d + 1).should.equal true

        Queen.moveValid(board, row, col, row + d - 1, col + d - 1)
          .should.equal true
        Queen.moveValid(board, row, col, row + d - 1, col - d + 1)
          .should.equal true
        Queen.moveValid(board, row, col, row - d + 1, col + d - 1)
          .should.equal true
        Queen.moveValid(board, row, col, row - d + 1, col - d + 1)
          .should.equal true

      it 'cannot move past friendly squares', ->
        Queen.moveValid(board, row, col, row + d + 1, col).should.equal false
        Queen.moveValid(board, row, col, row - d - 1, col).should.equal false
        Queen.moveValid(board, row, col, row, col + d + 1).should.equal false
        Queen.moveValid(board, row, col, row, col - d - 1).should.equal false

        Queen.moveValid(board, row, col, row + d + 1, col + d + 1)
          .should.equal false
        Queen.moveValid(board, row, col, row + d + 1, col - d - 1)
          .should.equal false
        Queen.moveValid(board, row, col, row - d - 1, col + d + 1)
          .should.equal false
        Queen.moveValid(board, row, col, row - d - 1, col - d - 1)
          .should.equal false

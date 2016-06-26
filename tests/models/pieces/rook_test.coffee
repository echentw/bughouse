chai = require('chai')
chai.should()

Constants = require('../../../models/helpers/constants')
Square = require('../../../models/helpers/square')
Rook = require('../../../models/pieces/rook')

describe 'Rook', ->
  describe 'moveValid()', ->
    board = null

    row = 4
    col = 3

    beforeEach ->
      board = ((Constants.NO_PIECE for i in [0 ... Constants.BOARD_SIZE]) \
                                   for j in [0 ... Constants.BOARD_SIZE])
      board[row][col] = Constants.W_ROOK

    describe 'empty board', ->
      it 'can move to valid squares', ->
        for r in [0 ... Constants.BOARD_SIZE]
          if r != row
            Rook.moveValid(board, row, col, r, col).should.equal true

        for c in [0 ... Constants.BOARD_SIZE]
          if c != col
            Rook.moveValid(board, row, col, row, c).should.equal true

      it 'cannot move to invalid squares', ->
        for r in [0 ... Constants.BOARD_SIZE]
          for c in [0 ... Constants.BOARD_SIZE]
            if r == row && c == col
              Rook.moveValid(board, row, col, r, c).should.equal false
            else if r != row && c != col
              Rook.moveValid(board, row, col, r, c).should.equal false

    describe 'friendly pieces in the way', ->
      dist = 2

      beforeEach ->
        board[row + dist][col] = Constants.W_KNIGHT
        board[row - dist][col] = Constants.W_KNIGHT
        board[row][col + dist] = Constants.W_KNIGHT
        board[row][col - dist] = Constants.W_KNIGHT

      it 'cannot move to friendly squares', ->
        Rook.moveValid(board, row, col, row + dist, col).should.equal false
        Rook.moveValid(board, row, col, row - dist, col).should.equal false
        Rook.moveValid(board, row, col, row, col + dist).should.equal false
        Rook.moveValid(board, row, col, row, col - dist).should.equal false

      it 'can move up to friendly squares', ->
        Rook.moveValid(board, row, col, row + 1, col).should.equal true
        Rook.moveValid(board, row, col, row - 1, col).should.equal true
        Rook.moveValid(board, row, col, row, col + 1).should.equal true
        Rook.moveValid(board, row, col, row, col - 1).should.equal true

      it 'cannot move past friendly squares', ->
        Rook.moveValid(board, row, col, row + dist + 1, col).should.equal false
        Rook.moveValid(board, row, col, row - dist - 1, col).should.equal false
        Rook.moveValid(board, row, col, row, col + dist + 1).should.equal false
        Rook.moveValid(board, row, col, row, col - dist - 1).should.equal false

    describe 'enemy pieces in the way', ->
      dist = 2

      beforeEach ->
        board[row + dist][col] = Constants.B_KNIGHT
        board[row - dist][col] = Constants.B_KNIGHT
        board[row][col + dist] = Constants.B_KNIGHT
        board[row][col - dist] = Constants.B_KNIGHT

      it 'can capture enemy pieces', ->
        Rook.moveValid(board, row, col, row + dist, col).should.equal true
        Rook.moveValid(board, row, col, row - dist, col).should.equal true
        Rook.moveValid(board, row, col, row, col + dist).should.equal true
        Rook.moveValid(board, row, col, row, col - dist).should.equal true

      it 'can move up to enemy pieces', ->
        Rook.moveValid(board, row, col, row + 1, col).should.equal true
        Rook.moveValid(board, row, col, row - 1, col).should.equal true
        Rook.moveValid(board, row, col, row, col + 1).should.equal true
        Rook.moveValid(board, row, col, row, col - 1).should.equal true

      it 'cannot move past enemy pieces', ->
        Rook.moveValid(board, row, col, row + dist + 1, col).should.equal false
        Rook.moveValid(board, row, col, row - dist - 1, col).should.equal false
        Rook.moveValid(board, row, col, row, col + dist + 1).should.equal false
        Rook.moveValid(board, row, col, row, col - dist - 1).should.equal false

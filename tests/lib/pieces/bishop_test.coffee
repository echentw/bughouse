chai = require('chai')
chai.should()

Constants = require('../../../lib/bughouse/helpers/constants')
Square = require('../../../lib/bughouse/helpers/square')
Bishop = require('../../../lib/bughouse/pieces/bishop')

describe 'Bishop', ->
  describe 'moveValid()', ->
    board = null

    row = 4
    col = 3

    beforeEach ->
      board = ((Constants.NO_PIECE for i in [0 ... Constants.BOARD_SIZE]) \
                                   for j in [0 ... Constants.BOARD_SIZE])

      board[row][col] = Constants.W_BISHOP

    it 'can move to a valid square', ->
      toRow = row + 2
      toCol = col - 2
      Bishop.moveValid(board, row, col, toRow, toCol).should.equal true

    it 'can capture an enemy piece', ->
      toRow = row - 3
      toCol = col + 3
      board[toRow][toCol] = Constants.B_PAWN
      Bishop.moveValid(board, row, col, toRow, toCol).should.equal true

    it 'cannot move to a square occupied by a friendly piece', ->
      toRow = row - 3
      toCol = col - 3
      board[toRow][toCol] = Constants.W_QUEEN
      Bishop.moveValid(board, row, col, toRow, toCol).should.equal false

    it 'cannot move to a square if something is in the middle', ->
      toRow = row + 3
      toCol = col + 3

      midRow = row + 2
      midCol = col + 2

      board[midRow][midCol] = Constants.B_KNIGHT
      Bishop.moveValid(board, row, col, toRow, toCol).should.equal false

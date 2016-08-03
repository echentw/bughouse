chai = require('chai')
chai.should()

Move = require('../../../lib/bughouse/helpers/move')
Board = require('../../../lib/bughouse/helpers/board')
Constants = require('../../../lib/bughouse/helpers/constants')
Square = require('../../../lib/bughouse/helpers/square')

Bishop = require('../../../lib/bughouse/pieces/bishop')

describe 'Bishop', ->
  describe 'moveValid()', ->
    board = new Board()
    prevMove = new Move(-1, -1, -1, -1)

    row = 4
    col = 3

    beforeEach ->
      board.clear()
      board.set(row, col, Constants.W_BISHOP)

    it 'can move to a valid square', ->
      move = new Move(row, col, row + 2, col - 2)
      Bishop.moveValid(board, move, prevMove).should.equal true

    it 'can capture an enemy piece', ->
      move = new Move(row, col, row - 3, col + 3)
      board.set(row - 3, col + 3, Constants.B_PAWN)
      Bishop.moveValid(board, move, prevMove).should.equal true

    it 'cannot move to a square occupied by a friendly piece', ->
      move = new Move(row, col, row - 3, col + 3)
      board.set(row - 3, col + 3, Constants.W_QUEEN)
      Bishop.moveValid(board, move, prevMove).should.equal false

    it 'cannot move to a square if something is in the middle', ->
      move = new Move(row, col, row + 3, col + 3)
      board.set(row + 2, col + 2, Constants.B_KNIGHT)
      Bishop.moveValid(board, move, prevMove).should.equal false

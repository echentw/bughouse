chai = require('chai')
chai.should()

_ = require('lodash')

Board = require('../../../lib/bughouse/helpers/board')
Move = require('../../../lib/bughouse/helpers/move')
Constants = require('../../../lib/bughouse/helpers/constants')
Square = require('../../../lib/bughouse/helpers/square')

Rook = require('../../../lib/bughouse/pieces/rook')

describe 'Rook', ->
  describe 'moveValid()', ->
    board = new Board()
    prevMove = new Move(-1, -1, -1, -1)

    row = 4
    col = 3

    beforeEach ->
      board.clear()
      board.set(row, col, Constants.W_ROOK)

    describe 'empty board', ->
      it 'can move to valid squares', ->
        for r in [0 ... Constants.BOARD_SIZE]
          if r != row
            move = new Move(row, col, r, col)
            Rook.moveValid(board, move, prevMove).should.equal true

        for c in [0 ... Constants.BOARD_SIZE]
          if c != col
            move = new Move(row, col, row, c)
            Rook.moveValid(board, move, prevMove).should.equal true

      it 'cannot move to invalid squares', ->
        for r in [0 ... Constants.BOARD_SIZE]
          for c in [0 ... Constants.BOARD_SIZE]
            move = new Move(row, col, r, c)
            if r == row && c == col
              Rook.moveValid(board, move, prevMove).should.equal false
            else if r != row && c != col
              Rook.moveValid(board, move, prevMove).should.equal false

    describe 'friendly pieces in the way', ->
      dist = 2

      beforeEach ->
        board.set(row + dist, col, Constants.W_KNIGHT)
        board.set(row - dist, col, Constants.W_KNIGHT)
        board.set(row, col + dist, Constants.W_KNIGHT)
        board.set(row, col - dist, Constants.W_KNIGHT)

      it 'cannot move to friendly squares', ->
        moves = [
          new Move(row, col, row + dist, col),
          new Move(row, col, row - dist, col),
          new Move(row, col, row, col + dist),
          new Move(row, col, row, col - dist)
        ]
        _.forEach(moves, (move) ->
          Rook.moveValid(board, move, prevMove).should.equal false
        )

      it 'can move up to friendly squares', ->
        moves = [
          new Move(row, col, row + 1, col),
          new Move(row, col, row - 1, col),
          new Move(row, col, row, col + 1),
          new Move(row, col, row, col - 1)
        ]
        _.forEach(moves, (move) ->
          Rook.moveValid(board, move, prevMove).should.equal true
        )

      it 'cannot move past friendly squares', ->
        moves = [
          new Move(row, col, row + dist + 1, col),
          new Move(row, col, row - dist - 1, col),
          new Move(row, col, row, col + dist + 1),
          new Move(row, col, row, col - dist - 1)
        ]
        _.forEach(moves, (move) ->
          Rook.moveValid(board, move, prevMove).should.equal false
        )

    describe 'enemy pieces in the way', ->
      dist = 2

      beforeEach ->
        board.set(row + dist, col, Constants.B_KNIGHT)
        board.set(row - dist, col, Constants.B_KNIGHT)
        board.set(row, col + dist, Constants.B_KNIGHT)
        board.set(row, col - dist, Constants.B_KNIGHT)

      it 'can capture enemy pieces', ->
        moves = [
          new Move(row, col, row + dist, col),
          new Move(row, col, row - dist, col),
          new Move(row, col, row, col + dist),
          new Move(row, col, row, col - dist)
        ]
        _.forEach(moves, (move) ->
          Rook.moveValid(board, move, prevMove).should.equal true
        )

      it 'can move up to enemy pieces', ->
        moves = [
          new Move(row, col, row + 1, col),
          new Move(row, col, row - 1, col),
          new Move(row, col, row, col + 1),
          new Move(row, col, row, col - 1)
        ]
        _.forEach(moves, (move) ->
          Rook.moveValid(board, move, prevMove).should.equal true
        )

      it 'cannot move past enemy pieces', ->
        moves = [
          new Move(row, col, row + dist + 1, col),
          new Move(row, col, row - dist - 1, col),
          new Move(row, col, row, col + dist + 1),
          new Move(row, col, row, col - dist - 1)
        ]
        _.forEach(moves, (move) ->
          Rook.moveValid(board, move, prevMove).should.equal false
        )

chai = require('chai')
chai.should()

Constants = require('../../lib/bughouse/helpers/constants')
Square = require('../../lib/bughouse/helpers/square')
Clock = require('../../lib/bughouse/helpers/clock')
Player = require('../../lib/bughouse/helpers/player')

Pawn = require('../../lib/bughouse/pieces/pawn')
Knight = require('../../lib/bughouse/pieces/knight')
Bishop = require('../../lib/bughouse/pieces/bishop')
Rook = require('../../lib/bughouse/pieces/rook')
Queen = require('../../lib/bughouse/pieces/queen')
King = require('../../lib/bughouse/pieces/king')

Chess = require('../../lib/bughouse/chess')

describe 'Chess', ->
  describe 'constructor()', ->
    playerWhite = new Player(0, 0)
    playerBlack = new Player(1, 1)

    chess = null

    beforeEach ->
      chess = new Chess(playerWhite, playerBlack)

    it 'pieces are initialized in the correct positions', ->
      board = chess.board

      # rooks
      board.get(0, 0).should.equal Constants.B_ROOK
      board.get(0, 7).should.equal Constants.B_ROOK
      board.get(7, 0).should.equal Constants.W_ROOK
      board.get(7, 7).should.equal Constants.W_ROOK

      # knights
      board.get(0, 1).should.equal Constants.B_KNIGHT
      board.get(0, 6).should.equal Constants.B_KNIGHT
      board.get(7, 1).should.equal Constants.W_KNIGHT
      board.get(7, 6).should.equal Constants.W_KNIGHT

      # bishops
      board.get(0, 2).should.equal Constants.B_BISHOP
      board.get(0, 5).should.equal Constants.B_BISHOP
      board.get(7, 2).should.equal Constants.W_BISHOP
      board.get(7, 5).should.equal Constants.W_BISHOP

      # queens
      board.get(0, 3).should.equal Constants.B_QUEEN
      board.get(7, 3).should.equal Constants.W_QUEEN

      # kings
      board.get(0, 4).should.equal Constants.B_KING
      board.get(7, 4).should.equal Constants.W_KING

      # pawns
      for col in [0...8]
        board.get(1, col).should.equal Constants.B_PAWN
        board.get(6, col).should.equal Constants.W_PAWN

      # empty squares
      for row in [2...6]
        for col in [0...8]
          board.get(row, col).should.equal Constants.NO_PIECE

    it 'castling privileges are correct', ->
      chess.playerWhite.canCastle[Constants.KINGSIDE].should.equal true
      chess.playerWhite.canCastle[Constants.QUEENSIDE].should.equal true

      chess.playerBlack.canCastle[Constants.KINGSIDE].should.equal true
      chess.playerBlack.canCastle[Constants.QUEENSIDE].should.equal true

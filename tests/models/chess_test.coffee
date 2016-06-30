chai = require('chai')
chai.should()

Constants = require('../../models/helpers/constants')
Square = require('../../models/helpers/square')
Clock = require('../../models/helpers/clock')

Pawn = require('../../models/pieces/pawn')
Knight = require('../../models/pieces/knight')
Bishop = require('../../models/pieces/bishop')
Rook = require('../../models/pieces/rook')
Queen = require('../../models/pieces/queen')
King = require('../../models/pieces/king')

Player = require('../../models/player')
Chess = require('../../models/chess')

describe 'Chess', ->
  describe 'constructor()', ->
    idWhite = 123
    idBlack = 20

    clockWhite = new Clock(300)
    clockBlack = new Clock(300)

    playerWhite = new Player(idWhite, clockWhite)
    playerBlack = new Player(idBlack, clockBlack)

    chess = null

    beforeEach ->
      chess = new Chess(playerWhite, playerBlack)

    it 'pieces are initialized in the correct positions', ->
      board = chess.board

      # rooks
      board[0][0].should.equal Constants.B_ROOK
      board[0][7].should.equal Constants.B_ROOK
      board[7][0].should.equal Constants.W_ROOK
      board[7][7].should.equal Constants.W_ROOK

      # knights
      board[0][1].should.equal Constants.B_KNIGHT
      board[0][6].should.equal Constants.B_KNIGHT
      board[7][1].should.equal Constants.W_KNIGHT
      board[7][6].should.equal Constants.W_KNIGHT

      # bishops
      board[0][2].should.equal Constants.B_BISHOP
      board[0][5].should.equal Constants.B_BISHOP
      board[7][2].should.equal Constants.W_BISHOP
      board[7][5].should.equal Constants.W_BISHOP

      # queens
      board[0][3].should.equal Constants.B_QUEEN
      board[7][3].should.equal Constants.W_QUEEN

      # kings
      board[0][4].should.equal Constants.B_KING
      board[7][4].should.equal Constants.W_KING

      # pawns
      for col in [0...8]
        board[1][col].should.equal Constants.B_PAWN
        board[6][col].should.equal Constants.W_PAWN

      # empty squares
      for row in [2...6]
        for col in [0...8]
          board[row][col].should.equal Constants.NO_PIECE

    it 'castling privileges are correct', ->
      players = chess.players
      players.white.canCastle[Constants.KINGSIDE].should.equal true
      players.white.canCastle[Constants.QUEENSIDE].should.equal true

      players.black.canCastle[Constants.KINGSIDE].should.equal true
      players.black.canCastle[Constants.QUEENSIDE].should.equal true

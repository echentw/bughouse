_ = require('lodash')

Constants = require('./helpers/constants')
Square = require('./helpers/square')

Pawn = require('./pieces/pawn')
Knight = require('./pieces/knight')
Bishop = require('./pieces/bishop')
Rook = require('./pieces/rook')
Queen = require('./pieces/queen')
King = require('./pieces/king')

class Chess
  constructor: (playerWhite, playerBlack) ->
    @players = {
      white: playerWhite
      black: playerBlack
    }
    @board = setupBoard()
    @turn = Constants.TURN_WHITE

  # returns true iff the move is valid
  # if the move is valid, then also updates the board
  move: (fromRow, fromCol, toRow, toCol) =>

    # check that the piece color is correct
    if @turn == Constants.TURN_WHITE
      if Square.getStatus(fromRow, fromCol) != Constants.WHITE_PIECE
        return false
    else
      if Square.getStatus(fromRow, fromCol) != Constants.BLACK_PIECE
        return false

    # determine whether the move is valid
    valid = false
    switch @board[fromRow][fromCol]
      when Constants.W_PAWN, Constants.B_PAWN
        valid = Pawn.moveValid(@board, fromRow, fromCol, toRow, toCol)

      when Constants.W_KNIGHT, Constants.B_KNIGHT
        valid = Knight.moveValid(@board, fromRow, fromCol, toRow, toCol)

      when Constants.W_BISHOP, Constants.B_BISHOP
        valid = Bishop.moveValid(@board, fromRow, fromCol, toRow, toCol)

      when Constants.W_ROOK, Constants.B_ROOK
        valid = Rook.moveValid(@board, fromRow, fromCol, toRow, toCol)
        if valid
          updateCastlingPrivilege(fromRow, fromCol)

      when Constants.W_QUEEN, Constants.B_QUEEN
        valid = Queen.moveValid(@board, fromRow, fromCol, toRow, toCol)

      when Constants.W_KING, Constants.B_KING
        valid = King.moveValid(@board, fromRow, fromCol, toRow, toCol)
        if !valid
          if checkValidCastle(fromRow, fromCol, toRow, toCol)
            valid = true
        if valid
          updateCastlingPrivilege(fromRow, fromCol)

    # if the move is valid
    if valid

      # move the piece
      @board[toRow][toCol] = @board[fromRow][fromCol]
      @board[fromRow][fromCol] = Constants.NO_PIECE

      # switch control to the other player
      if @turn == Constants.TURN_WHITE
        @turn = Constants.TURN_BLACK
      else
        @turn = Constnats.TURN_WHITE

    return valid

  # PRIVATE

  # assumes that piece is a king
  checkValidCastle = (fromRow, fromCol, toRow, toCol) =>
    piece = @board[fromRow][fromCol]

    if piece == Constants.W_KING
      player = @players.white
      correctRow = Constants.BOARD_SIZE - 1
    else
      player = @players.black
      correctRow = 0

    # make sure that the rows are correct
    if toRow != correctRow || fromRow != correctRow
      return false

    # check the columns
    if toCol == fromCol - 2
      if player.canCastle[Constants.KINGSIDE] == false
        return false
    else if toCol == fromCol + 2
      if player.canCastle[Constants.QUEENSIDE] == false
        return false
    else
      return false

    return true

  updateCastlingPrivilege = (fromRow, fromCol) =>
    piece = @board[fromRow][fromCol]
    if piece == Constants.W_KING
      @players.white.canCastle[Constants.KINGSIDE] = false
      @players.white.canCastle[Constants.QUEENSIDE] = false
    else if piece == Constants.B_KING
      @players.black.canCastle[Constants.KINGSIDE] = false
      @players.black.canCastle[Constants.QUEENSIDE] = false
    else
      if fromRow == 0 && fromCol == 0
        # rook on A8
        @players.black.canCastle[Constants.QUEENSIDE] = false
      else if fromRow == 0 && fromCol == Constants.BOARD_SIZE - 1
        # rook on H8
        @players.black.canCastle[Constants.KINGSIDE] = false
      else if fromRow == Constants.BOARD_SIZE - 1 && fromCol == 0
        # rook on A1
        @players.white.canCastle[Constants.QUEENSIDE] = false
      else if fromRow == Constants.BOARD_SIZE - 1 &&
          fromCol == Constants.BOARD_SIZE - 1
        # rook on A8
        @players.white.canCastle[Constants.KINGSIDE] = false

  # initialize the board
  setupBoard = ->
    board = []

    board.push([
      Constants.B_ROOK, Constants.B_KNIGHT, Constants.B_BISHOP,
      Constants.B_QUEEN, Constants.B_KING,
      Constants.B_BISHOP, Constants.B_KNIGHT, Constants.B_ROOK
    ])
    board.push((Constants.B_PAWN for i in [0 ... Constants.BOARD_SIZE]))

    for i in [0 ... (Constants.BOARD_SIZE - 4)]
      board.push((Constants.NO_PIECE for i in [0 ... Constants.BOARD_SIZE]))

    board.push((Constants.W_PAWN for i in [0 ... Constants.BOARD_SIZE]))
    board.push([
      Constants.W_ROOK, Constants.W_KNIGHT, Constants.W_BISHOP,
      Constants.W_QUEEN, Constants.W_KING,
      Constants.W_BISHOP, Constants.W_KNIGHT, Constants.W_ROOK
    ])

    return board

module.exports = Chess

_ = require('lodash')

Constants = require('./helpers/constants')
Square = require('./helpers/square')
Board = require('./helpers/board')

Pawn = require('./pieces/pawn')
Knight = require('./pieces/knight')
Bishop = require('./pieces/bishop')
Rook = require('./pieces/rook')
Queen = require('./pieces/queen')
King = require('./pieces/king')

class Chess
  # @param {Player} playerWhite
  # @param {Player} playerBlack
  constructor: (playerWhite, playerBlack) ->
    @playerWhite = playerWhite
    @playerBlack = playerBlack
    @board = new Board()
    @turn = Constants.TURN_WHITE
    @previousMove = new Move(-1, -1, -1, -1)

  # Returns true iff the move is valid.
  # If the move is valid, then also updates the board.
  #
  # @param {Move} move
  # @param {Number} promotionChoice Promotion choice when a pawn reaches
  #   the end of the board. Only applicable if the moving piece is a pawn.
  # @return {Boolean}
  move: (move, promotionChoice = null) =>
    promoting = false

    # check that the piece color is correct
    if @turn == Constants.TURN_WHITE
      if Square.getStatus(move.fromRow, move.fromCol) != Constants.WHITE_PIECE
        return false
    else
      if Square.getStatus(move.fromRow, move.fromCol) != Constants.BLACK_PIECE
        return false

    # determine whether the move is valid
    valid = false
    switch @board.get(move.fromRow, move.fromCol)
      when Constants.W_PAWN, Constants.B_PAWN
        valid = Pawn.moveValid(@board, move, @prevMove, @previousMove)
        promoting = isPromoting(
          Square.getStatus(board, move.fromRow, move.fromCol),
          toRow
        )

      when Constants.W_KNIGHT, Constants.B_KNIGHT
        valid = Knight.moveValid(@board, move, @prevMove)

      when Constants.W_BISHOP, Constants.B_BISHOP
        valid = Bishop.moveValid(@board, move, @prevMove)

      when Constants.W_ROOK, Constants.B_ROOK
        valid = Rook.moveValid(@board, move, @prevMove)
        if valid
          updateCastlingPrivilege(move)

      when Constants.W_QUEEN, Constants.B_QUEEN
        valid = Queen.moveValid(@board, move, @prevMove)

      when Constants.W_KING, Constants.B_KING
        valid = King.moveValid(@board, move, @prevMove)
        if valid
          updateCastlingPrivilege(move)
        else
          if checkValidCastle(move, @prevMove)
            valid = true

    # if the move is valid
    if valid
      @prevMove = move

      # move the piece
      @board.move(move)
      if promoting
        @board.set(move.toRow, move.toCol) = promotionChoice

      # switch control to the other player
      if @turn == Constants.TURN_WHITE
        @turn = Constants.TURN_BLACK
      else
        @turn = Constnats.TURN_WHITE

    return valid

  # PRIVATE

  # assumes that the piece is a pawn
  isPromoting = (fromStatus, toRow) =>
    if fromStatus == Constants.WHITE_PIECE
      return (toRow == 0)
    else
      return (toRow == Constants.BOARD_SIZE - 1)

  # assumes that piece is a king
  checkValidCastle = (move, @prevMove) =>
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

  updateCastlingPrivilege = (move) =>
    fromRow = move.fromRow
    fromCol = move.fromCol

    piece = @board.get(fromRow, fromCol)
    if piece == Constants.W_KING
      @playerWhite.canCastle[Constants.KINGSIDE] = false
      @playerWhite.canCastle[Constants.QUEENSIDE] = false
    else if piece == Constants.B_KING
      @playerBlack.canCastle[Constants.KINGSIDE] = false
      @playerBlack.canCastle[Constants.QUEENSIDE] = false
    else
      if fromRow == 0 && fromCol == 0
        # rook on A8
        @playerBlack.canCastle[Constants.QUEENSIDE] = false
      else if fromRow == 0 && fromCol == Constants.BOARD_SIZE - 1
        # rook on H8
        @playerBlack.canCastle[Constants.KINGSIDE] = false
      else if fromRow == Constants.BOARD_SIZE - 1 && fromCol == 0
        # rook on A1
        @playerWhite.canCastle[Constants.QUEENSIDE] = false
      else if fromRow == Constants.BOARD_SIZE - 1 &&
          fromCol == Constants.BOARD_SIZE - 1
        # rook on A8
        @playerWhite.canCastle[Constants.KINGSIDE] = false

module.exports = Chess

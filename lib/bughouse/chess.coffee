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
    moveType = Constants.NORMAL_MOVE

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
        valid = Pawn.moveValid(@board, move, @prevMove)
        if isPromoting(move)
          moveType = Constants.PROMOTING_MOVE
        else if isEnPassant(move)
          moveType = Constants.EN_PASSANT_MOVE

      when Constants.W_KNIGHT, Constants.B_KNIGHT
        valid = Knight.moveValid(@board, move, @prevMove)

      when Constants.W_BISHOP, Constants.B_BISHOP
        valid = Bishop.moveValid(@board, move, @prevMove)

      when Constants.W_ROOK, Constants.B_ROOK
        valid = Rook.moveValid(@board, move, @prevMove)

      when Constants.W_QUEEN, Constants.B_QUEEN
        valid = Queen.moveValid(@board, move, @prevMove)

      when Constants.W_KING, Constants.B_KING
        valid = King.moveValid(@board, move, @prevMove)
        if !valid && checkValidCastle(move)
          moveType = Constants.CASTLING_MOVE
          valid = true

    if valid
      @prevMove = move
      @board.move(move, moveType, promotionChoice)

      # update castle privilege and switch control to other player
      if @turn == Constants.TURN_WHITE
        @playerWhite.updateCastlePrivilege(move)
        @turn = Constants.TURN_BLACK
      else
        @playerBlack.updateCastlePrivilege(move)
        @turn = Constants.TURN_BLACK

    return valid

  # PRIVATE METHODS

  # Returns true iff the piece lands on the back rank.
  # Assumes that the piece is a pawn, and that the move is valid.
  #
  # @param {Move} move
  # @return {Boolean}
  isPromoting = (move) =>
    fromStatus = Square.getStatus(@board, move.fromRow, move.fromCol)
    if fromStatus == Constants.WHITE_PIECE
      return (move.toRow == 0)
    else
      return (move.toRow == Constants.BOARD_SIZE - 1)

  # Returns true iff the move is a valid en passant.
  # Assumes that the piece is a pawn.
  #
  # @param {Move} move
  # @return {Boolean}
  isEnPassant = (move) =>
    # validate enemy piece
    if Square.getStatus(board, move.toRow, move.toCol) != Constants.NO_PIECE
      return false

    enemyPiece = @board.get(move.fromRow, move.toCol)
    if @turn == Constants.TURN_WHITE
      if enemyPiece != Constants.B_PAWN
        return false
    else
      if enemyPiece != Constants.W_PAWN
        return false

    direction = if (@turn == Constants.TURN_WHITE) then -1 else 1
    if @prevMove.toRow != @prevMove.fromRow - 2 * direction
      return false

    # validate the pawn doing the capture
    if move.toRow != move.fromRow + direction
      return false
    if Math.abs(move.toCol - move.fromCol) != 1
      return false

    return true

  # Returns true iff the move is a valid castle.
  # Assumes that piece is a king.
  #
  # @param {move} move
  # @return {Boolean}
  checkValidCastle = (move) =>
    piece = @board.get(fromRow, fromCol)

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

module.exports = Chess

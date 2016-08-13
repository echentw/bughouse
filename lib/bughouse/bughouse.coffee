_ = require('lodash')

Team = require('./helpers/team')
Chess = require('./chess')

class Bughouse

  # Begins the game of bughouse.
  #
  # Teams: (player1, player2) and (player3, player4)
  # Game 1: {White: player1, Black: player3}
  # Game 2: {Black: Player2, White: Player4}
  #
  # @param {Player} player1
  # @param {Player} player2
  # @param {Player} player3
  # @param {Player} player4
  constructor: (player1, player2, player3, player4) ->
    @team1 = new Team(player1, player2)
    @team2 = new Team(player3, player4)

    @game1 = new Chess(player1, player3)
    @game2 = new Chess(player4, player2)

    @winner = null

  move: (boardNum, move, promotionChoice = null) =>
    if @winner != null
      return false

    if boardNum == 1
      turn = @game1.turn
      success = @game1.move(move, promotionChoice)

      if success

        # handle taking pieces logic
        pieceTaken = @game1.pieceTaken
        if pieceTaken != Constants.NO_PIECE
          if turn == Constants.TURN_WHITE
            # player 1 took the piece, passes to player 2
            piece = getColorBlindPiece(pieceTaken)
            @team1.player2.addReserve(piece)

          else
            # player 3 took the piece, passes to player 4
            piece = getColorBlindPiece(pieceTaken)
            @team2.player2.addReserve

        # check for a winner
        if @game1.winner != null
          if @game1.winner == @team1.playerWhite
            @winner = @team1
          else
            @winner = @team2

    else
      turn = @game2.turn
      success = @game2.move(move, promotionChoice)

      if success

        # handle taking pieces logic
        pieceTaken = @game2.pieceTaken
        if pieceTaken != Constants.NO_PIECE
          if turn == Constants.TURN_WHITE
            # player 4 took the piece, pass to player 3
            piece = getColorBlindPiece(pieceTaken)
            @team2.player1.addReserve(piece)

          else
            # player 2 took the piece, pass to player 1
            @team2.player1.addReserve(piece)

        # check for a winner
        if @game2.winner != null
          if @game1.winner == @team1.playerBlack
            @winner = @team1
          else
            @winner = @team2

  # PRIVATE METHODS

  getColorBlindPiece = (piece) ->
    switch @board.get(move.fromRow, move.fromCol)
      when Constants.W_PAWN, Constants.B_PAWN
        return Constants.PAWN
      when Constants.W_KNIGHT, Constants.B_KNIGHT
        return Constants.KNIGHT
      when Constants.W_BISHOP, Constants.B_BISHOP
        return Constants.BISHOP
      when Constants.W_ROOK, Constants.B_ROOK
        return Constants.ROOK
      when Constants.W_QUEEN, Constants.B_QUEEN
        return Constants.QUEEN
      when Constants.W_KING, Constants.B_KING
        return Constants.KING

module.exports = Bughouse

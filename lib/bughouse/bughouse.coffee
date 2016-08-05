_ = require('lodash')

Team = require('./helper/team')
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
      result = @game1.move(move, promotionChoice)
      if @game1.winner != null
        if @game1.winner == @team1.playerWhite
          @winner = @team1
        else
          @winner = @team2
    else
      result = @game2.move(move, promotionChoice)
      if @game2.winner != null
        if @game1.winner == @team1.playerBlack
          @winner = @team1
        else
          @winner = @team2

module.exports = Bughouse

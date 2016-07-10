_ = require('lodash')

Chess = require('./chess')

class Bughouse
  # players = {a0: Player, a1: Player, b0: Player, b1: Player}
  #   a0 is team A, white
  #   b0 is team B, black
  constructor: (players) ->
    @players = players
    @game0 = new Chess(players.a0, players.b0)
    @game1 = new Chess(players.a1, players.b1)

  move: (boardNum, move) =>
    switch boardNum
      when 0
        @game0.move(move)
      else
        @game1.move(move)

module.exports = Bughouse

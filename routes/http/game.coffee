database = null

# GET game page
game = (req, res, next) ->
  gameID = req.params['id']

  # if not an existing session, start a new one
  if !req.session.username || req.session.gameID != gameID
    res.render('join', {gameID: req.params.id, message: ''})
    return

  res.render('game', {
    gameID: req.session.gameID,
    username: req.session.username
  })

# POST join game
join = (req, res, next) ->
  username = req.body['username']
  gameID = req.body['gameID']

  game = database.find(gameID)
  if !game
    res.render('join', {
      gameID: gameID,
      message: 'Game not found.'
    })

  success = game.addUser(username)
  if !success
    res.render('join', {
      gameID: gameID,
      message: 'That username has been taken.'
    })

  req.session.username = username
  req.session.gameID = gameID

  res.redirect('/game/' + gameID)

module.exports.attach = (app, db) ->
  database = db
  app.get('/game/:id', game)
  app.post('/game/:id/join', join)

database = null

# GET home page
home = (req, res, next) ->
  res.render('home')
  return

# POST create a game
createGame = (req, res, next) ->
  # clear the current session
  req.session.gameID = null
  req.session.username = null

  # create new session
  gameID = database.add()
  req.session.gameID = gameID
  req.session.username = req.body['username']

  # add the creator to list of users
  game = database.find(gameID)
  game.addUser(req.session.username)

  res.redirect('/game/' + gameID)

# Attach route handlers to the app
module.exports.attach = (app, db) ->
  database = db
  app.get('/', home)
  app.post('/create', createGame)

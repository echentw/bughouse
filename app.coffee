express = require('express')
path = require('path')
favicon = require('static-favicon')
logger = require('morgan')
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')
debug = require('debug')('my-application')

index = require('./routes/index')
game = require('./routes/game')

app = express()

# view engine setup
app.set('views', path.join(__dirname, 'views'))
app.set('view engine', 'ejs')

app.use(favicon())
app.use(logger('dev'))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded())
app.use(cookieParser())
app.use(express.static(path.join(__dirname, 'public')))

app.use('/', index)
app.use('/game', game)

#/ catch 404 and forwarding to error handler
app.use((req, res, next) ->
  err = new Error('Not Found')
  err.status = 404
  next err
  return
)

#/ error handlers

# development error handler
# will print stacktrace
if app.get('env') == 'development'
  app.use((err, req, res, next) ->
    res.status err.status or 500
    res.render 'error',
      message: err.message
      error: err
    return
  )

# production error handler
# no stacktraces leaked to user
app.use((err, req, res, next) ->
  res.status err.status or 500
  res.render 'error',
    message: err.message
    error: {}
  return
)

# start the server
app.set('port', process.env.PORT || 3000)
server = app.listen(app.get('port'), ->
  debug('Express server listening on port ' + server.address().port)
  return
)

module.exports = app

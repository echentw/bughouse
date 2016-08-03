class Clock
  constructor: (seconds, done) ->
    # time is stored in milliseconds
    @remainingTime = seconds * 1000
    @isRunning = false
    @checkpointTime = null
    @done = done

  start: =>
    @isRunning = true
    @checkpointTime = new Date().getTime()

  stop: =>
    @isRunning = false
    currentTime = new Date().getTime()
    difference = currentTime - @checkpointTime
    @checkpointTime = currentTime
    @remainingTime -= difference

  getSeconds: =>
    if @isRunning
      currentTime = new Date().getTime()
      difference = currentTime - @checkpointTime
      return (@remainingTime - difference) // 1000
    else
      return @remainingTime // 1000

module.exports = Clock

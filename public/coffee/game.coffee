# Chessboard.js does not return an object on load. Instead, it creates
# a ChessBoard object for use. That's why 'chessboard' is not loaded
# into an object.
require(['jquery', 'client', 'chessboard'], ($, Client) ->
  $(document).ready( ->

    board1 = ChessBoard('board1', 'start')
    board2 = ChessBoard('board2', 'start')

    board1.orientation('white')
    board2.orientation('black')

    gameID = $('#gameID').text()
    username = $('#username').text()

    client = new Client(gameID, username, board1, board2)

    $('.sit-btn').click((event) ->
      id = event.target.id
      seatNum = Number(id[id.length - 1])
      client.sit(seatNum)
    )
  )
)

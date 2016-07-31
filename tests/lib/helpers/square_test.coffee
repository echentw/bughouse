chai = require('chai')
chai.should()

Constants = require('../../../lib/bughouse/helpers/constants')
Square = require('../../../lib/bughouse/helpers/square')

describe 'Square', ->

  describe 'inBoard()', ->
    validRow = 3
    validCol = 5

    invalidRows = [-1, Constants.BOARD_SIZE]
    invalidCols = [-1, Constants.BOARD_SIZE]

    it 'outside the board', ->
      for invalidRow in invalidRows
        Square.inBoard(invalidRow, validCol).should.equal false
      for invalidCol in invalidCols
        Square.inBoard(validRow, invalidCol).should.equal false

    it 'inside the board', ->
      Square.inBoard(validRow, validCol).should.equal true

  describe 'getStatus()', ->
    board = ((Constants.NO_PIECE for i in [0 ... Constants.BOARD_SIZE]) \
                                 for j in [0 ... Constants.BOARD_SIZE])

    wRow = 3
    wCol = 5

    bRow = 2
    bCol = 4

    board[wRow][wCol] = Constants.W_BISHOP
    board[bRow][bCol] = Constants.B_BISHOP

    it 'no piece', ->
      for row in [0 ... Constants.BOARD_SIZE]
        for col in [0 ... Constants.BOARD_SIZE]
          if row != bRow && row != wRow && col != bCol && col != wCol
            Square.getStatus(board, row, col).should.equal Constants.NO_PIECE

    it 'white piece', ->
      Square.getStatus(board, wRow, wCol).should.equal Constants.WHITE_PIECE

    it 'black piece', ->
      Square.getStatus(board, bRow, bCol).should.equal Constants.BLACK_PIECE

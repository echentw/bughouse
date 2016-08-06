class Constants

  # the size of the chess board
  #############################
  this.BOARD_SIZE = 8

  # square colors
  ###############
  this.WHITE_SQUARE = 0
  this.BLACK_SQUARE = 1

  # piece identifiers
  ###################
  this.NO_PIECE = -1

  # color-blind pieces
  ####################
  this.PAWN = 0
  this.KNIGHT = 1
  this.BISHOP = 2
  this.ROOK = 3
  this.QUEEN = 4
  this.KING = 5

  # white and black pieces
  ########################
  this.W_PAWN = 0
  this.W_KNIGHT = 1
  this.W_BISHOP = 2
  this.W_ROOK = 3
  this.W_QUEEN = 4
  this.W_KING = 5

  this.B_PAWN = 6
  this.B_KNIGHT = 7
  this.B_BISHOP = 8
  this.B_ROOK = 9
  this.B_QUEEN = 10
  this.B_KING = 11

  # the status of a square (occupied by no piece, white piece, or black piece)
  ############################################################################
  this.WHITE_PIECE = 0
  this.BLACK_PIECE = 1

  # directions (only applicable for pawns)
  ########################################
  this.UP = -1
  this.DOWN = 1

  # keep track of whose turn it is
  ################################
  this.TURN_WHITE = 0
  this.TURN_BLACK = 1

  # sides of castling
  ###################
  this.KINGSIDE = 0
  this.QUEENSIDE = 1

  # type of move
  ##############
  this.NORMAL_MOVE = 0
  this.PROMOTING_MOVE = 1
  this.CASTLING_MOVE = 2
  this.EN_PASSANT_MOVE = 3

module.exports = Constants

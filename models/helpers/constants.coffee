class Constants

  # the size of the chess board
  @BOARD_SIZE: 8

  # square colors
  @WHITE_SQUARE: 0
  @BLACK_SQUARE: 1

  # piece identifiers
  @W_PAWN: 0
  @W_KNIGHT: 1
  @W_BISHOP: 2
  @W_ROOK: 3
  @W_QUEEN: 4
  @W_KING: 5

  @B_PAWN: 6
  @B_KNIGHT: 7
  @B_BISHOP: 8
  @B_ROOK: 9
  @B_QUEEN: 10
  @B_KING: 11

  # the status of a square (occupied by no piece, white piece, or black piece)
  @NO_PIECE: 0
  @WHITE_PIECE: 1
  @BLACK_PIECE: 2

  # directions (only applicable for pawns)
  @UP: -1
  @DOWN: 1

module.exports = Constants

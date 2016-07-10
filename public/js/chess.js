var onDragStart = function(source, piece, position, orientation) {
  console.log('onDragStart');
  console.log(source + ', ' + piece + ', ' + position + ', ' + orientation);
};

var onDrop = function(source, target, piece, newPosition) {
  console.log('onDrop');
  console.log(source + ', ' + target + ', ' + piece + ', ' + newPosition);
};

var config = {
  draggable: true,
  position: 'start',
  onDragStart: onDragStart,
  sparePieces: false,
  onDrop: onDrop
};

var board = ChessBoard('board1', config);

$('#move1Btn').on('click', function() {
  // var ruyLopez = 'r1bqkbnr/pppp1ppp/2n5/1B2p3/4P3/5N2/PPPP1PPP/RNBQK2R';
  var ruyLopez = 'r1bqkbnr/pppp1ppp/11n11111/1B11p111/1111P111/11111N11/PPPP1PPP/RNBQK11R';
  board.position(ruyLopez, false);
});

var express = require('express');
var router = express.Router();

/* GET game page. */
router.get('/', function(req, res) {
  res.render('game', { title: 'Bughouse' });
});

module.exports = router;

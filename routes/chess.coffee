express = require('express')

router = express.Router()

# GET chess game page.
router.get('/', (req, res) ->
  res.render 'chess', title: 'Bughouse'
)

module.exports = router

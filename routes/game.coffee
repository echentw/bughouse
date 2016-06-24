express = require('express')

router = express.Router()

# GET game page.
router.get('/', (req, res) ->
  res.render 'game', title: 'Bughouse'
  return
)

module.exports = router

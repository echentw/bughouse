express = require('express')

router = express.Router()

# GET bughouse game page.
router.get('/', (req, res) ->
  res.render 'bughouse', title: 'Bughouse'
)

module.exports = router

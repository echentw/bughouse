express = require('express')

router = express.Router()

# GET index page
router.get('/', (req, res) ->
  res.render 'index', title: 'Bughouse'
)

module.exports = router

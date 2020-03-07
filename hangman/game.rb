require_relative 'word'
require_relative 'view'
require_relative 'controller'
require_relative 'router'

view = View.new
controller = Controller.new(view)

router = Router.new(controller)

# Start the app
router.run

app = app || {};

# Todo Router
# -----------

Workspace = Backbone.Router.extend(

	routes: 
		'*filter': 'setFilter'

	setFilter: (param)->
		# Set the current filter to be used
  		window.app.TodoFilter = param.trim() || ''
  		window.app.Todos.trigger('filter')
  		return
	
)

app.TodoRouter = new Workspace()

Backbone.history.start();
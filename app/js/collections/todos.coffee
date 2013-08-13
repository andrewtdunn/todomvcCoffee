app = app || {};

# Todo Collection
# ----------------

# The collection of todos is backed by *localStorage* instead of a remote
# server

TodoList = Backbone.Collection.extend(

	# Reference to this collection's model
	model:
		app.Todo

	# Save all of the todo items under the '"todos-backbone"' namespace.
	# Note that you will need to have the Backbone localStorage plug-in
	# loaded inside your page in order for this to work. If testing
	# in the console without this present, comment out the next line
	# to avoid running into an exception
	localStorage: 
		new Store('todos-backbone')

	# Filter Down the lest of all todo items that are finished
	completed: -> 
		@filter (todo) ->	
			todo.get('completed')

	# Filter down the list to only todo items that are still not finished
	remaining: ->
		# apply allows us to define the context of this within our function scope
		@without.apply this, @completed()

	# We keep the Todos in sequential order, despite being saved by unordered 
	# GUID in the database. This generates he next order number for new items. 
	nextOrder: ->
		return 1 unless @length
		@last().get('order') + 1

	# todos are sorted by their original insertion order
	comparator: (todo) ->
		todo.get "order"
)

app.Todos = new TodoList()
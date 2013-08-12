app = app || {}

# The Application
# ---------------

# Our overal *AppView* is the top-level piece of UI.
app.AppView = Backbone.View.extend(

	el: 
		'#todoapp'

	# our template for the line of statistics at the bottom of the app
	statsTemplate: 
		_.template($('#statsTemplate').html())

	# Delegated events for creating new items, and clearing completed ones
	events: 
		'keypress #new-todo': 'createOnEnter'
		'click #clear-completed': 'clearCompleted'
		'click #toggle-all': 'toggleAllComplete'

	# At initialization we bind the relevant events on the `Todos`
	# collection, when items are changed or added
	initialization: -> 
		@allCheckbox = @$('#toggle-all')[0]
		@$input = @$('#new-todo')
		@$footer = @$('#footer')
		@$main = $('#main')

		@listenTo(app.Todos, 'add', @addOne)
		@listenTo(app.Todos, 'reset', @addAll)
		return

	# Add a single todo item to the list by creating a view for it, and
	# appending its element to the <ul>
	addOne: ->
		view = new app.TodoView(model.Todo)
		$('#todo-list').append view.render().el
		return

	# add all items in the **Todos** collection at once
	addAll: ->
		@$('#todo-list').html ''
		app.Todos.each @addOne, this
		return



)
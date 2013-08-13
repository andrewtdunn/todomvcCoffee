app = app || {}

# The Application
# ---------------

# Our overal *AppView* is the top-level piece of UI.
app.AppView = Backbone.View.extend(

	el: 
		'#todoapp'

	# our template for the line of statistics at the bottom of the app
	statsTemplate: 
		_.template($('#stats-template').html())

	# Delegated events for creating new items, and clearing completed ones
	events: 
		'keypress #new-todo': 'createOnEnter'
		'click #clear-completed': 'clearCompleted'
		'click #toggle-all': 'toggleAllComplete'

	# At initialization we bind the relevant events on the `Todos`
	# collection, when items are changed or added
	initialize: -> 
		console.log 'init'
		@input = @$('#new-todo')
		@allCheckbox = @$('#toggle-all')[0]
		@$footer = @$('#footer')
		@$main = $('#main')

		window.app.Todos.on 'add', @addOne, @
		window.app.Todos.on 'reset', @addAll, @

		window.app.Todos.on 'change:completed', @filterOne, @
		window.app.Todos.on 'filter', @filterAll, @
		window.app.Todos.on 'all', @render, @

		app.Todos.fetch()
		return

	render: ->
		completed = app.Todos.completed().length
		remaining = app.Todos.remaining().length

		if app.Todos.length
			@$main.show()
			@$footer.show()
			@$footer.html @statsTemplate(
				completed: completed
				remaining: remaining
			)
			@$("#filters li a").removeClass("selected").filter("[href=\"#/" + (app.TodoFilter or "") + "\"]").addClass "selected"
		else
			@$main.hide()
			@$footer.hide()
		@allCheckbox.checked = not remaining
		
	# Add a single todo item to the list by creating a view for it, and
	# appending its element to the <ul>
	addOne: (todo)->
		console.log "adding one"
		view = new app.TodoView {model:todo}
		$('#todo-list').append view.render().el
		return

	# add all items in the **Todos** collection at once
	addAll: ->
		@$('#todo-list').html ''
		app.Todos.each @addOne, this
		return

	filterOne: (todo) ->
		todo.trigger 'visible'

	filterAll: ->
		app.Todos.each @filterOne, this

	# Generates the attributes for a new todo item
	newAttributes: ->
		title: @input.val().trim()
		order: app.Todos.nextOrder()
		completed: false

	# If you hit return in the main input field, create new Todo model,
	# persisting it to localStorage
	createOnEnter: (event) ->
		if (event.which isnt ENTER_KEY or not @input.val().trim() )
			return
		app.Todos.create @newAttributes()
		@input.val ''
		return

	# Clear all completed todo items, destroying their models
	clearCompleted: ->
		_.invoke app.Todos.completed(), 'destroy'
		return false

	toggleAllComplete: ->
		completed = @allCheckbox.checked

		app.Todos.each ( todo )->
			todo.save {'completed':completed}
			return
		return
)
























































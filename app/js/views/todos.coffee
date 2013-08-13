app = app || {};

# Todo Item View
# --------------

# The DOM element for a Todo item ...
app.TodoView = Backbone.View.extend(

	# ... is a list tag.
	tagname:
		'li'

	# Cache the template function for a single item
	template: 
		_.template $('#item-template').html()

	# The DOM events specific to an item
	events: 
		'dblclick label': 'edit'
		'keypress .edit': 'updateOnEnter'
		'blur .edit': 'close'

	# The TodoView listens for changes to its model, rendering. Since there's
	# a one-to-one correspondence between a **Todo** and a **TodoView** in this
	# app, we set a direct reference on the model for convenience. 

	initialize: ->
		console.log 'initialize'
		@listenTo @model, 'change', @render

	# Rerenders the titles of the todo item.
	render: ->
		console.log "render"
		@$el.html @template @model.toJSON()
		@$input = @$('edit')
		return @

	# Switch this view into `"editing"` mode, displaying the input field
	edit: ->
		@$el.addClass 'editing'
		@$input.focus
		return

	# Close the `"editing"` mode, saving changes to the model
	close: ->
		value = @$input.val trim()
		@model.save {title: value} if value
		@$el.removeClass 'editing'
		return

	# If you hit 'enter', we're through editing the item.
	updateOnEnter: (e) ->
		@close() if e.which is ENTER_KEY
		return

)
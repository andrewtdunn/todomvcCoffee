'use strict'

app = app || {};

# Todo Item View
# --------------

# The DOM element for a Todo item ...
app.TodoView = Backbone.View.extend(

	# ... is a list tag.
	tagName:
		'li'

	# Cache the template function for a single item
	template: 
		_.template $('#item-template').html()

	# The DOM events specific to an item
	events: 
		'click .toggle':'togglecompleted'
		'dblclick label': 'edit'
		'click .destroy':'clear'
		'keypress .edit': 'updateOnEnter'
		'blur .edit': 'close'

	# The TodoView listens for changes to its model, rendering. Since there's
	# a one-to-one correspondence between a **Todo** and a **TodoView** in this
	# app, we set a direct reference on the model for convenience. 

	initialize: ->
		console.log 'initialize'
		@model.on 'change', @render, @
		@model.on 'destroy', @remove, @
		@model.on 'visible', @toggleVisible, @
		return

	# Rerenders the titles of the todo item.
	render: ->
		console.log "render"
		@$el.html @template @model.toJSON()

		@$el.toggleClass 'completed', @model.get 'completed'
		@toggleVisible()
		@input = @$('.edit')
		return @

	# Toggles visibility of the todo item
	toggleVisible: ->
		@$el.toggleClass 'hidden', @isHidden()
		return

	# Determines if item should be hidden
	isHidden: ->
		isCompleted = @model.get 'completed'
		(not isCompleted and app.TodoFilter is "completed") or (isCompleted and app.TodoFilter is "active")

	togglecompleted: ->
		@model.toggle()
		return	

	# Switch this view into `"editing"` mode, displaying the input field
	edit: ->
		@$el.addClass 'editing'
		@input.focus()
		return

	

	# Close the `"editing"` mode, saving changes to the model
	close: ->
		value = @input.val().trim()
		if value
			@model.save {title: value} 
		else
			@clear()
		@$el.removeClass 'editing'
		return

	# If you hit 'enter', we're through editing the item.
	updateOnEnter: (e) ->
		@close() if e.which is ENTER_KEY
		return

	# Remove the item, destroy the model from *localStorage* and delete its view
	clear: ->
		@model.destroy()
		return















)
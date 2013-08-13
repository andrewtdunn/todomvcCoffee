app = app || {};

# Todo Model
# - - - - - - 
# Our basick **Todo** model has 'title', 'order', and 'completed attributes'.

app.Todo = Backbone.Model.extend(
  
  # Default attributes ensure that each todo created has 'title' and 
  # 'completed' keys. 
  defaults:
    title: ''
    completed: false

  toggle: ->
    @save completed: not @get("completed")
)
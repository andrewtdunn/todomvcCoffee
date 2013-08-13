// Generated by CoffeeScript 1.6.3
var app;

app = app || {};

app.AppView = Backbone.View.extend({
  el: '#todoapp',
  statsTemplate: _.template($('#stats-template').html()),
  events: {
    'keypress #new-todo': 'createOnEnter',
    'click #clear-completed': 'clearCompleted',
    'click #toggle-all': 'toggleAllComplete'
  },
  initialize: function() {
    console.log('init');
    this.input = this.$('#new-todo');
    this.allCheckbox = this.$('#toggle-all')[0];
    this.$footer = this.$('#footer');
    this.$main = $('#main');
    window.app.Todos.on('add', this.addOne, this);
    window.app.Todos.on('reset', this.addAll, this);
    window.app.Todos.on('change:completed', this.filterOne, this);
    window.app.Todos.on('filter', this.filterAll, this);
    window.app.Todos.on('all', this.render, this);
    app.Todos.fetch();
  },
  render: function() {
    var completed, remaining;
    completed = app.Todos.completed().length;
    remaining = app.Todos.remaining().length;
    if (app.Todos.length) {
      this.$main.show();
      this.$footer.show();
      this.$footer.html(this.statsTemplate({
        completed: completed,
        remaining: remaining
      }));
      this.$("#filters li a").removeClass("selected").filter("[href=\"#/" + (app.TodoFilter || "") + "\"]").addClass("selected");
    } else {
      this.$main.hide();
      this.$footer.hide();
    }
    return this.allCheckbox.checked = !remaining;
  },
  addOne: function(todo) {
    var view;
    console.log("adding one");
    view = new app.TodoView({
      model: todo
    });
    $('#todo-list').append(view.render().el);
  },
  addAll: function() {
    this.$('#todo-list').html('');
    app.Todos.each(this.addOne, this);
  },
  filterOne: function(todo) {
    return todo.trigger('visible');
  },
  filterAll: function() {
    return app.Todos.each(this.filterOne, this);
  },
  newAttributes: function() {
    return {
      title: this.input.val().trim(),
      order: app.Todos.nextOrder(),
      completed: false
    };
  },
  createOnEnter: function(event) {
    if (event.which !== ENTER_KEY || !this.input.val().trim()) {
      return;
    }
    app.Todos.create(this.newAttributes());
    this.input.val('');
  },
  clearCompleted: function() {
    _.invoke(app.Todos.completed(), 'destroy');
    return false;
  },
  toggleAllComplete: function() {
    var completed;
    completed = this.allCheckbox.checked;
    app.Todos.each(function(todo) {
      todo.save({
        'completed': completed
      });
    });
  }
});

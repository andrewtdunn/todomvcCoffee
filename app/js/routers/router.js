// Generated by CoffeeScript 1.6.3
var Workspace, app;

app = app || {};

Workspace = Backbone.Router.extend({
  routes: {
    '*filter': 'setFilter'
  },
  setFilter: function(param) {
    window.app.TodoFilter = param.trim() || '';
    window.app.Todos.trigger('filter');
  }
});

app.TodoRouter = new Workspace();

Backbone.history.start();

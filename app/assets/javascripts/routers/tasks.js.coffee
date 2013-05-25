class MyTasks.Routers.Tasks extends Backbone.Router
  routes:
    '' : 'index'
  index: ->
    tasks = new MyTasks.Collections.Tasks
    new MyTasks.Views.Index collection: tasks

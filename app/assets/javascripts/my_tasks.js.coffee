window.MyTasks =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    tasks = new MyTasks.Collections.Tasks()
    new MyTasks.Views.Index collection: tasks
    
$(document).ready ->
  MyTasks.init()
window.MyTasks =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->    
    new MyTasks.Routers.Tasks
    Backbone.history.start()
    
$(document).ready ->
  MyTasks.init()
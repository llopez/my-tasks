class MyTasks.Views.Index extends Backbone.View
  el: '#main-view'
  events:
    'keypress input:first' : 'createTask'
  initialize: ->
    @$input = @$el.find('input')
    @$list = @$el.find('ul')
    @listenTo(@collection, 'add', @addTask)
    @collection.fetch()
  createTask: (e) ->
    if e.which == 13
      @collection.create {title: @$input.val()}, wait: true
      @$input.val('')
  addTask: (model) ->
    view = new MyTasks.Views.Task model: model
    @$list.append view.render().el
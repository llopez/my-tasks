class MyTasks.Views.Task extends Backbone.View
  tagName: 'li'
  template: JST['tasks/task']
  initialize: ->
    @listenTo(@model, 'destroy', @remove)
    @listenTo(@model, 'change', @render)
  events:
    'click button.close' : 'destroyTask'
    'dblclick' : 'editMode'
    'keypress input' : 'updateTask'
    'keyup input' : 'exitEdit'
  exitEdit: (e) ->
    if e.which == 27
      @listMode()
  editMode: ->
    @$el.addClass 'editable'
    @$input.select()
  listMode: ->
    @$el.removeClass 'editable'
  destroyTask: ->
    @model.destroy()
  updateTask: (e) ->
    if e.which == 13
      @model.save {title: @$input.val()}, wait: true
      @listMode()
  render: ->
    @$el.html @template(@model.toJSON())
    @$input = @$el.find('input')
    @
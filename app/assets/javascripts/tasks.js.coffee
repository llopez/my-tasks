# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class TaskModel extends Backbone.Model
  validate: (attrs, options) ->
    if attrs.errors
      err = _.map _.pairs(attrs.errors), (x) ->
        "#{x[0].toUpperCase()} #{x[1]}"
      if err.length > 0
        err_str = _.reduce err, (m, v) ->
          m + v
        error_view = new ErrorView({error: err_str})
        jQuery('#main-view .page-header').after error_view.render().el
        setTimeout(->
          error_view.hide()
        , 3000)
        err_str

class TaskCollection extends Backbone.Collection
  model: TaskModel
  url: '/tasks'
  
task_collection = new TaskCollection()

class ErrorView extends Backbone.View
  className: 'alert fade in alert-error'
  template: _.template(jQuery('#error-view-template').html())
  render: ->
    @$el.html @template(@options)
    @
  hide: ->
    @$el.alert('close')
    
class TaskView extends Backbone.View
  tagName: 'li'
  template: _.template(jQuery('#task-view-template').html())
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

class MainView extends Backbone.View
  el: '#main-view'
  events:
    'keypress input:first' : 'createTask'
  initialize: ->
    @$input = @$el.find('input')
    @$list = @$el.find('ul')
    @listenTo(task_collection, 'add', @addTask)
    task_collection.fetch()
  createTask: (e) ->
    if e.which == 13
      task_collection.create {title: @$input.val()}, wait: true
      @$input.val('')
  addTask: (task_model) ->
    task_view = new TaskView({model: task_model})
    @$list.append task_view.render().el

new MainView()
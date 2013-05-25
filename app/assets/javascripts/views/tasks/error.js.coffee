class MyTasks.Views.Error extends Backbone.View
  className: 'alert fade in alert-error'
  template: JST['tasks/error']
  render: ->
    @$el.html @template(@options)
    @
  hide: ->
    @$el.alert('close')
class MyTasks.Models.Task extends Backbone.Model
  validate: (attrs, options) ->
    if attrs.errors
      err = _.map _.pairs(attrs.errors), (x) ->
        "#{x[0].toUpperCase()} #{x[1]}"
      if err.length > 0
        err_str = _.reduce err, (m, v) ->
          m + v
        view = new MyTasks.Views.Error error: err_str
        jQuery('#main-view .page-header').after view.render().el
        setTimeout(->
          view.hide()
        , 3000)
        err_str
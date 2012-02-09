window.Task = Backbone.Model.extend({
    initialize: ->

    defaults: ->
        {
            description: '',
            duration: 0,
            id: null
        }

    url: ->
        if this.id then '/tasks' + this.id else '/tasks'
})

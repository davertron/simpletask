window.Task = Backbone.Model.extend({
    initialize: ->

    defaults: ->
        {
            description: '',
            duration: 0,
            formatted_duration: '00:00:00'
            id: null
        }

    url: ->
        if this.id then '/tasks' + this.id else '/tasks'

})

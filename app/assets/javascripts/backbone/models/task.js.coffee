window.Task = Backbone.Model.extend({
    initialize: ->

    defaults: ->
        {
            description: '',
            duration: 0,
            time_entries: []
        }

    url: ->
        if this.id then '/tasks/' + this.id else '/tasks'

})

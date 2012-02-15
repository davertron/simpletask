window.TimeEntry = Backbone.Model.extend
    initialize: ->

    defaults: ->
        d =
            startDate: new Date()
            endDate: null

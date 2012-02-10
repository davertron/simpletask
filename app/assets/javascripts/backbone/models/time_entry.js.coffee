window.TimeEntry = Backbone.Model.extend({
    initialize: ->

    defaults: ->
        {
            startDate: new Date(),
            endDate: null
        }
})

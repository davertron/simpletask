window.TaskView = Backbone.View.extend({
    el: $('body'),
    events: {
        'click #create-task': 'addTask'
    },
    initialize: ->

    render: ->
})



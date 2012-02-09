window.TaskList = Backbone.Collection.extend({
    model: Task,
    url: '/tasks'
})


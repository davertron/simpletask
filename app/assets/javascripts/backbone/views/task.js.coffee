window.TaskView = Backbone.View.extend({
    tagName: 'li',
    className: 'task',

    events: {
        'click .delete-link': 'delete',
        'click .log-link': 'log'
    },

    initialize: ->
        this.template =  _.template($('#task-template').html())
        this.model.bind 'change', this.render, this
        this.model.bind 'destroy', this.remove, this

    render: ->
        $(this.el).html(this.template(this.model.toJSON()))
        this

    log: ->

    delete: ->
        this.model.destroy()
        return false

    remove: ->
        $(this.el).remove()
})

window.TasksView = Backbone.View.extend({
    events: {
        'click #create-task': 'addTask'
    },

    initialize: ->
        this.description = $ '#task_description'
        this.duration = $ '#task_duration'

        this.duration.hide()

        this.collection.bind 'add', this.addOne, this

    render: ->
        $('#tasks').html ''
        this.collection.forEach (task) =>
            this.addOne task

    addTask: ->
        description = this.description.val()
        duration = this.duration.val()
        this.collection.create {description: description, duration: if duration == '' then 0 else duration}
        this.description.val('')
        this.duration.val('')

        return false

    addOne: (task) ->
        view = new TaskView {model: task}
        html = view.render().el
        $('#tasks').append html

})

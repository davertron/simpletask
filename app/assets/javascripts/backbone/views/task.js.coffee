window.TaskView = Backbone.View.extend({
    tagName: 'li',

    events: {
        'click .delete-link': 'remove'
    },

    initialize: ->
        this.template =  _.template($('#task-template').html())
        this.model.bind 'change', this.render, this
        this.model.bind 'destroy', this.remove, this

    render: ->
        $(this.el).html(this.template(this.model.toJSON()))
        this

    remove: ->
        alert('wow!')
        $(this.el).remove()
})

window.TasksView = Backbone.View.extend({
    events: {
        'click #create-task': 'addTask'
    },

    initialize: ->
        this.description = $ '#task_description'
        this.duration = $ '#task_duration'

        this.collection.bind 'add', this.addOne, this

    render: ->

    addTask: ->
        this.collection.create {description: this.description.val(), duration: this.duration.val()}
        this.description.val(null)
        this.duration.val(null)

        return false

    addOne: (task) ->
        view = new TaskView {model: task}
        console.log view.render().el
        $('#tasks').append view.render().el
})

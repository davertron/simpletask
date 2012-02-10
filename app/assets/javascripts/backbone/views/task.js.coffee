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
        this.isLogging = _.any(this.model.get('time_entries'), (entry) ->
            !entry.endDate
        )

        console.log(this.isLogging)

        if this.isLogging
            console.log "I'm loggin' already bro"
        else
            console.log "Currently not loggin' bro"

    render: ->
        model_obj = this.model.toJSON()
        model_obj.duration = _.reduce(this.model.get('time_entries'), (acc, entry) ->
            if entry.startDate and entry.endDate
                start = new Date entry.startDate
                end = new Date entry.endDate

                acc += (end - start) / 1000
            else
                start = new Date entry.startDate
                end = new Date()

                acc += (end - start) / 1000
        , 0)

        $(this.el).html(this.template(model_obj))
        this

    log: ->
        if this.isLogging
            entry = _.find(this.model.get('time_entries'), (entry) ->
                !entry.endDate
            )
            entry.endDate = new Date()
            this.model.save()
            console.log "I will stop logging"
        else
            this.model.get('time_entries').push(new TimeEntry({startDate: new Date()}))
            this.model.save()
            console.log "I will start logging time"

        this.isLogging = !this.isLogging

        true

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
        $('#task_duration').hide()

        this.collection.bind 'add', this.addOne, this

    render: ->
        $('#tasks').html ''
        this.collection.forEach (task) =>
            this.addOne task

    addTask: ->
        description = this.description.val()
        this.collection.create {description: description}
        this.description.val('')

        return false

    addOne: (task) ->
        view = new TaskView {model: task}
        html = view.render().el
        $('#tasks').append html

})

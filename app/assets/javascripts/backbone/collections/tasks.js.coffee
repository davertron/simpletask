window.TaskList = Backbone.Collection.extend
    model: Task
    url: '/tasks.json'

    hasAtLeastOneUnarchivedTask: ->
        status = false
        this.forEach (task) ->
            if not task.get('archived')
                status = true
                return false

        status

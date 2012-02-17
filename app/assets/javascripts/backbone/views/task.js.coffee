window.TaskView = Backbone.View.extend
    tagName: 'li'
    className: 'task'

    events:
        'click .delete-link': 'delete',
        'click .archive-link': 'archive',
        'click .unarchive-link': 'unarchive',
        'click .log-link': 'log'
        'click .toggle-time-entries': 'toggleTimeEntries'

    initialize: ->
        this.parent = this.options.parent
        this.template =  _.template($('#task-template').html())
        this.model.bind 'change', this.render, this
        this.model.bind 'destroy', this.remove, this
        this.isLogging = _.any(this.model.get('time_entries'), (entry) ->
            !entry.endDate
        )

        _.bindAll(this)

        this.updateDuration()

    updateDuration: ->
        if this.isLogging
            this.$('.duration').html(this.formatDuration(this.model.getDuration()) + ' total')
            this.$('.duration-today').html(this.formatDuration(this.model.getDurationToday()) + ' today')
        setTimeout this.updateDuration, 10000

    formatDuration: (seconds) ->
        result = {days: 0, hours: 0, minutes: 0}

        if seconds > 86400
            result.days = parseInt(seconds / 86400, 10)
            seconds = seconds % 86400

        if seconds > 3600
            result.hours = parseInt(seconds / 3600, 10) 
            seconds = seconds % 3600

        if seconds > 60
            result.minutes = parseInt(seconds / 60, 10) 
            seconds = seconds % 60

        duration_string = ''

        if result.days > 0
            if result.days > 1
                duration_string += result.days + ' days '
            else
                duration_string += result.days + ' day '

        if result.hours > 0
            if result.hours > 1
                duration_string += result.hours + ' hours '
            else
                duration_string += result.hours + ' hour '

        if result.minutes > 0
            if result.minutes > 1
                duration_string += result.minutes + ' minutes '
            else
                duration_string += result.minutes + ' minute '

        if duration_string == ''
            duration_string = 'No time logged'

        duration_string

    getLogButtonText: ->
        text
        if this.isLogging
            text = 'Stop'
        else
            text = 'Log'

        text

    getLogButtonClass: ->
        if this.isLogging then 'btn-danger' else 'btn-success'

    renderTimeEntries: ->
        self = this
        self.$('.time-entries').html ''
        _.each(self.model.get('time_entries'), (entry) ->
            tView = new TimeEntryView({model: entry, parent: self})
            self.$('.time-entries').append tView.render().el
        )

    render: ->
        self = this
        model_obj = self.model.toJSON()
        model_obj.duration = self.formatDuration(self.model.getDuration()) + ' total'
        model_obj.duration_today = self.formatDuration(self.model.getDurationToday()) + ' today'
        model_obj.logButtonText = self.getLogButtonText()
        model_obj.logButtonClass = self.getLogButtonClass()
        $(self.el).html(self.template(model_obj))
        self.renderTimeEntries()
        self

    log: ->
        if this.isLogging
            entry = _.find(this.model.get('time_entries'), (entry) ->
                !entry.endDate
            )
            entry.endDate = (new Date()).toISOString()
        else
            this.model.get('time_entries').push({startDate: (new Date()).toISOString()})

        this.isLogging = !this.isLogging
        this.$('.log-button-text').html this.getLogButtonText()
        this.$('.btn.log-link, .btn.log-link-drop').removeClass('btn-success').removeClass('btn-danger').addClass this.getLogButtonClass()
        this.model.save()
        this.renderTimeEntries()

        false

    delete: ->
        this.model.destroy()
        false

    archive: ->
        this.model.set({archived: true})
        this.model.save()
        this.parent.render()

        false

    unarchive: ->
        this.model.set({archived: false})
        this.model.save()
        this.parent.render()

        false

    remove: ->
        $(this.el).remove()

    toggleTimeEntries: ->
        this.$('.time-entries').toggle()

        false

window.TasksView = Backbone.View.extend
    events:
        'click #create-task': 'addTask'
        'click #toggle-archived-visibility': 'toggleArchived'

    initialize: ->
        this.description = $ '#task_description'
        this.showArchived = this.options.showArchived or false
        $('#task_duration').hide()

        this.collection.bind 'add', this.addOne, this

    render: ->
        $('#tasks').html ''

        this.collection.forEach (task) =>
            if this.showArchived or not task.get 'archived'
                this.addOne task

    addTask: ->
        description = this.description.val()
        this.collection.create {description: description}
        this.description.val('')

        false

    addOne: (task) ->
        view = new TaskView {model: task, parent: this}
        html = view.render().el
        $('#tasks').append html

    toggleArchived: ->
        this.showArchived = !this.showArchived
        this.render()

        false

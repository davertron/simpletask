window.NewTimeEntryView = Backbone.View.extend
    events:
        'click #save-new-time-entry': 'saveNewEntry'

    initialize: ->
        this.template = _.template($('#new-time-entry-template').html())
        this.task = this.options.task
        this.timeRegex = /[0-9]{1,2}[\/\-][0-9]{1,2}[\/\-][0-9]{4}\s+[0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}/

        _.bindAll(this)

    render: ->
        $(this.el).html(this.template())
        this

    saveNewEntry: ->
        $startInput = $('#new-time-entry-start')
        $endInput = $('#new-time-entry-end')
        start = $startInput.val()
        end = $endInput.val()

        if this.timeRegex.test(start) and this.timeRegex.test(end)
            this.task.model.get('time_entries').push({startDate: (new Date(start)).toISOString(), endDate: (new Date(end)).toISOString()})
            this.task.model.save()
            this.task.render()
            this.task.renderTimeEntries()

            $startInput.val('')
            $endInput.val('')
        else
            console.log 'Bad time formats'
            #displayBadTimeEntries()

        return false


window.TimeEntryView = Backbone.View.extend
    tagName: 'tr'

    events:
        'click .edit-entry': 'edit'
        'click .delete-entry': 'delete'

    initialize: ->
        this.template = _.template($('#time-entry-template').html())
        this.task = this.options.task

        _.bindAll(this)

    formatDate: (date) ->
        formattedDate = null
        if date
            d = new Date date
            formattedDate = _.template("{{= month }}/{{= day }}/{{= year}} {{= hour }}:{{= minute }}:{{= second}}", {
                month: d.getMonth() + 1
                day: d.getDate()
                year: d.getFullYear()
                hour: _.zeroFill(d.getHours(), 2)
                minute: _.zeroFill(d.getMinutes(), 2)
                second: _.zeroFill(d.getSeconds(), 2)
            })

        formattedDate

    render: ->
        $(this.el).html(this.template({startDate: this.formatDate(this.model.startDate), endDate: this.formatDate(this.model.endDate)}))
        this

    edit: ->
        $(this.el).replaceWith(new EditableTimeEntryView({model: this.model, task: this.options.task, timeView: this}).render().el)

        return false

    delete: ->
        self = this
        new_entries = _.filter(this.task.model.get('time_entries'), (entry) -> entry.id != self.model.id)
        this.task.model.set({'time_entries': new_entries })
        this.task.model.save()
        this.task.renderTimeEntries()

window.EditableTimeEntryView = Backbone.View.extend
    tagName: 'tr'

    events:
        'click .save-edit-entry': 'save'
        'click .cancel-edit-entry': 'cancel'

    initialize: ->
        this.template = _.template($('#time-entry-edit-template').html())
        this.task = this.options.task
        this.timeView = this.options.timeView

    render: ->
        start = new Date this.model.startDate
        end = new Date this.model.endDate
        $(this.el).html(this.template(
            startDate: this.timeView.formatDate(start)
            endDate: this.timeView.formatDate(end)
        ))
        this

    save: ->
        newStart = this.$('.edit-start').val()
        newEnd = this.$('.edit-end').val()

        newStart = new Date(newStart)
        newEnd = new Date(newEnd)

        this.task.model.get('time_entries').splice(_.indexOf(this.task.model.get('time_entries'), this.model), 1, {startDate: newStart.toISOString(), endDate: newEnd.toISOString()})

        this.task.model.save()
        this.task.renderTimeEntries()
        this.task.render()

    cancel: ->
        this.task.renderTimeEntries()


window.Task = Backbone.Model.extend
    initialize: ->

    defaults: ->
        d =
            description: ''
            time_entries: []

    url: ->
        if this.id then '/tasks/' + this.id else '/tasks'

    getDuration: ->
        duration = parseInt(_.reduce(this.get('time_entries'), (acc, entry) ->
            if entry.startDate and entry.endDate
                start = new Date entry.startDate
                end = new Date entry.endDate
            else
                start = new Date entry.startDate
                end = new Date()

            acc += (end - start) / 1000
        , 0), 10)

    getDurationToday: ->
        duration = parseInt(_.reduce(this.get('time_entries'), (acc, entry) ->
            today = new Date()
            start = new Date entry.startDate
            if start.getDate() == today.getDate() and
               start.getFullYear() == today.getFullYear() and
               start.getMonth() == today.getMonth()
                if entry.startDate and entry.endDate
                    start = new Date entry.startDate
                    end = new Date entry.endDate
                else
                    start = new Date entry.startDate
                    end = new Date()

                acc += (end - start) / 1000
            acc
        , 0), 10)


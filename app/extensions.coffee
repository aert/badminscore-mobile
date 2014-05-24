# Badminscore.Extensions.View

class Badminscore.Extensions.View extends Backbone.View

    initialize: () ->
        this.router = new Badminscore.Router()

    render: (options) ->
        if options.page == true
            this.$el.addClass('page')
        return this

    transitionIn: (options, callback) ->
        view = this
        
        if options.noPrevious == true
            view.$el.fadeOut('slow', callback)
        else
            view.$el.show(callback)

    transitionOut: (callback) ->
        view = this

        view.$el.slideUp(callback)

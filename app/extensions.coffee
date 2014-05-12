# Badminscore.Extensions.View

class Badminscore.Extensions.View extends Backbone.View

    initialize: () ->
        this.router = new Badminscore.Router()

    render: (options) ->
        if options.page == true
            this.$el.addClass('page')
        return this

    transitionIn: (callback) ->
        view = this
        
        transitionIn = () ->
            view.$el.addClass('is-visible')
            view.$el.on('transitionend', () ->
                if _.isFunction(callback)
                    callback()
            )

        _.delay(transitionIn, 20)

    transitionOut: (callback) ->
        view = this

        view.$el.removeClass('is-visible')
        view.$el.on('transitionend', () ->
            if _.isFunction(callback)
                callback()
        )


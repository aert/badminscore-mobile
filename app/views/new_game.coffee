# Badminscore.Views.NewGame

class Badminscore.Views.NewGame extends Backbone.Marionette.View
    className: 'view-newGame'

    render: () ->
        template = _.template($('#template-newGame').html())
        this.$el.html(template)
        return this

# Badminscore.Views.Index

class Badminscore.Views.Index extends Backbone.Marionette.View
    className: 'view-index'

    render: () ->
        template = _.template($('#template-index').html())
        this.$el.html(template)
        return this

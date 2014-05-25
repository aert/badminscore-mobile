# navigation.coffee

class Badminscore.Views.Navigation extends Backbone.Marionette.View
    className: 'view-navigation'

    render: () ->
        template = _.template($('#template-navigation').html())
        this.$el.html(template)
        return this

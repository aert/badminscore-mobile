# navigationView.coffee

class Badminscore.Views.Navigation extends Backbone.Marionette.View
    className: 'view-navigation'

    initialize: (model) ->
        @model = model
        this.listenTo(@model, "change:selectedId", this.render)

    render: () ->
        template = _.template($('#template-navigation').html(), model: @model)
        this.$el.html(template)
        return this

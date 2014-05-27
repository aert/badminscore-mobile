# Badminscore.Views.ShowGame

class Badminscore.Views.GameDetails extends Backbone.Marionette.View

    className: "view_show_game"
    
    initialize: (model) ->
        @model = model


    render: () ->
        template = _.template($("#template-gameDetails").html(), model: @model)
        this.$el.html(template)
        return this

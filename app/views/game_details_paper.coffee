
class Badminscore.Views.GameDetailsPaper extends Backbone.Marionette.View

    className: "view_game_details_paper"
    
    initialize: (model) ->
        @model = model
        @maxNumPlay = @model.get("totalScore1") + @model.get("totalScore2")

    render: () ->
        template = _.template($("#template-gameDetailsPaper").html(),
                              model: @model)
        this.$el.html(template)
        return this

    onShow: () ->
        this.bindModel()

    # -- Private Methods ------------------------------------------------------

    bindModel: () ->
        servicePlayer = @model.get("servicePlayer")
        placementData = @model.getServiceReceiver(@maxNumPlay)

        id = @model.get("id")
        this.$el.find("#modelDetailsLink").attr("href", "#/game/#{id}")

        if servicePlayer == 0
            this.$el.find("#pdfDirection1").html("S")
            this.$el.find("#pdfDirection2").html("R")
        else
            this.$el.find("#pdfDirection1").html("R")
            this.$el.find("#pdfDirection2").html("S")

        # Scores


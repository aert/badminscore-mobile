
class Badminscore.Views.GameDetailsPaper extends Backbone.Marionette.View

    className: "view_game_details_paper"
    
    initialize: (model) ->
        @model = model
        @maxNumPlay = @model.get("totalScore1") + @model.get("totalScore2")
        @isDouble = @model.get("isTypeDouble")

    render: () ->
        if @isDouble == false
            template = _.template($("#template-gameDetailsPaperSingle").html(), model: @model)
        else
            template = _.template($("#template-gameDetailsPaperDouble").html(), model: @model)

        this.$el.html(template)
        return this

    onShow: () ->
        this.bindModel()

    # -- Private Methods ------------------------------------------------------

    bindModel: () ->
        if not @isDouble
            @bindModelSingle()
        else
            @bindModelDouble()


    bindModelSingle: () ->
        servicePlayer = @model.get("servicePlayer") - 1

        id = @model.get("id")
        this.$el.find("#modelDetailsLink").attr("href", "#/game/#{id}")

        if servicePlayer == 0
            this.$el.find("#pdfDirection1").html("S")
            this.$el.find("#pdfDirection2").html("R")
        else
            this.$el.find("#pdfDirection1").html("R")
            this.$el.find("#pdfDirection2").html("S")

    bindModelDouble: () ->
        servicePlayer = @model.get("servicePlayer") - 1
        receiverPlayer = @model.get("receiverPlayer") - 1

        id = @model.get("id")
        this.$el.find("#modelDetailsLink").attr("href", "#/game/#{id}")

        this.$el.find("#pdfDirection" + servicePlayer).html("S")
        this.$el.find("#pdfDirection" + receiverPlayer).html("R")

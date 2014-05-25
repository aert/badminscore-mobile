# Badminscore.Views.NewGame

class Badminscore.Views.NewGame extends Backbone.Marionette.View
    className: 'view-newGame'

    initialize: (model) ->
        @model = model
        this.listenTo(@model, "change:isTypeDouble", this.onGameDataChanged)

    events:
        "click .radPlayerCount": "onSwitchGameType"
        "click #btnNewGameFirst": "onBtnNewGameFirst"

    # -- Events ---------------------------------------------------------------
    onSwitchGameType: () ->
        this.onGameDataChanged()

        radValue = this.$el.find("input[name=radPlayerCount]:checked").val()
        isDouble = radValue == "double"

        @model.set(isTypeDouble: isDouble)

        if isDouble
            this.$el.find(".new_game_simple").hide()
            this.$el.find(".new_game_double").fadeIn(duration: 1500)
        else
            this.$el.find(".new_game_double").hide()
            this.$el.find(".new_game_simple").fadeIn(duration: 1500)

    onBtnNewGameFirst: () ->
        this.$el.find('#newGameConfirm').modal()


    onGameDataChanged: () ->
        enableBtnNewGameFirst = false

        hasRadValue = !!this.$el.find("input[name=radPlayerCount]:checked").val()
        enableBtnNewGameFirst = hasRadValue

        if enableBtnNewGameFirst
            this.$el.find("#btnNewGameFirst").removeAttr("disabled")
        else
            this.$el.find("#btnNewGameFirst").attr("disabled", "disabled")

        

    # -- Render ---------------------------------------------------------------
    render: () ->
        template = _.template($('#template-newGame').html())
        this.$el.html(template)
        return this

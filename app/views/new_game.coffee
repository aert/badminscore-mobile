# Badminscore.Views.NewGame

class Badminscore.Views.NewGame extends Backbone.Marionette.View
    className: 'view-newGame'

    initialize: (model) ->
        @model = model
        this.listenTo(@model, "change", this.onGameDataChanged)

        @changesCount = 0

    events:
        "click .radPlayerCount": "onSwitchGameType"
        "click #btnNewGameFirst": "onBtnNewGameFirst"
        "change #servicePlayer": "onServicePlayerChanged"

    # -- Binding --------------------------------------------------------------
    bindings:
        '#refereeFirstname': 'refereeFirstname'
        '#refereeSurname': 'refereeSurname'
        '#gameField': 'field'

        '#player1Firstname': 'player1Firstname'
        '#player1Surname': 'player1Surname'
        '#player2Firstname': 'player2Firstname'
        '#player2Surname': 'player2Surname'

        '#playerA1Firstname': 'playerA1Firstname'
        '#playerA1Surname': 'playerA1Surname'
        '#playerA2Firstname': 'playerA2Firstname'
        '#playerA2Surname': 'playerA2Surname'
        '#playerB1Firstname': 'playerB1Firstname'
        '#playerB1Surname': 'playerB1Surname'
        '#playerB2Firstname': 'playerB2Firstname'
        '#playerB2Surname': 'playerB2Surname'


    # -- Events ---------------------------------------------------------------
    onSwitchGameType: () ->
        radValue = this.$el.find("input[name=radPlayerCount]:checked").val()

        if !!radValue
            isDouble = radValue == "double"
        else
            isDouble = null

        @model.set(isTypeDouble: isDouble)

        if isDouble
            this.$el.find(".new_game_simple").hide()
            this.$el.find(".new_game_double").fadeIn(duration: 1500)
        else
            this.$el.find(".new_game_double").hide()
            this.$el.find(".new_game_simple").fadeIn(duration: 1500)

    onBtnNewGameFirst: () ->
        this.bindConfirmForm()
        this.$el.find('#newGameConfirm').modal()


    onGameDataChanged: () ->
        @changesCount++
        console.log('changes: ' + @changesCount)

        enableBtnNewGameFirst = false

        hasRadValue = @model.get("isTypeDouble") != null
        enableBtnNewGameFirst = hasRadValue

        if enableBtnNewGameFirst
            this.$el.find("#btnNewGameFirst").removeAttr("disabled")
        else
            this.$el.find("#btnNewGameFirst").attr("disabled", "disabled")

    onServicePlayerChanged: () ->
        newValue = parseInt(this.$el.find("#servicePlayer").val())
        console.log('onServicePlayerChanged: ' + newValue)

        if newValue < 1
            @model.set("servicePlayer", 0)
            this.$el.find("#newGameFormReceiver").hide()
            return
        
        @model.set("servicePlayer", newValue)
        this.$el.find("#newGameFormReceiver").fadeIn(duration: 1500)
        
        
    bindConfirmForm: () ->
        console.log('bindConfirmForm')

        $select = this.$el.find('#servicePlayer').first()
        @model.bindServiceOptions($select)


    # -- Render ---------------------------------------------------------------
    render: () ->
        template = _.template($('#template-newGame').html())
        this.$el.html(template)
        this.stickit()
        return this
